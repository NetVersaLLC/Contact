#!/usr/bin/env ruby
require 'awesome_print'
require './config/environment.rb'
require 'csv'
require 'open-uri'

pass = File.open("passwords_for_users.txt", "w")
images_dir = 'public/system/businesses/logos/splatr/'
file = ARGV.shift

headers = nil
CSV.open(file, :encoding => 'windows-1251:utf-8').each do |row|
  headers = row and next unless headers
  hash = {}
  row.each_with_index do |data,i|
    if headers[i] =~ /phone|fax/ and data =~ /\((\d\d\d)\) (.*)/
      data = "#{$1}-#{$2}"
    end
    if headers[i] =~ /year_founded/
      if data =~ /\d+\/\d+\/(\d+)/
        if $1.to_i > 12
          data = '19'+$1
        else
          data = '20'+$1
        end
      else
        data = '1900'
      end
    end
    if headers[i] =~ /geographic/
      if data =~ /Didn't Ask/
        data = 'Within 20 Miles'
      elsif data == nil or data.strip == ''
        data = 'Within 20 Miles'
      end
    end
    hash[ headers[i] ] = data
    # This column is actually the questions "Display Hours?"
    # The only useful info we get here is if it's open by appointment
    if headers[i] =~ /open_by_appointment/
      if data =~ /Call for Appointment/
        hash[ headers[i] ] = true
      else
        hash.delete headers[i]
      end
    end

    # We just parse the accepted types and add their respective rields
    if headers[i] =~ /accepts/ and data and data.strip != ''
      hash.delete headers[i]
      types = {
        'Cash' => 'accepts_cash',
        'Check' => 'accepts_checks',
        'MasterCard' => 'accepts_mastercard',
        'Visa' => 'accepts_visa',
        'Discover' => 'accepts_discover',
        'Diner\'s Club' => 'accepts_diners',
        'American Express' => 'accepts_amex'
        # Travelers Check
        # Financing
      }
      data.split(/,/).each do |type|
        hash[ types[type] ] = true
      end
    elsif headers[i] =~ /accepts/ # data is nil
      hash.delete headers[i]
    end

    if headers[i] =~ /logo/ and data
      if data =~ /tinypic\/$/
        STDERR.puts "Downloading tinypic: #{data}"
        html = open(data).read
        if html =~ /<a href="([^"]+)" target="_blank">View Raw Image/i
          data = $1
          STDERR.puts "Got: #{data}"
        end
      end
      if data =~ /\.(jpe?g|png|gif)$/i
        hash.delete headers[i]
        filename = "#{images_dir}#{hash['business_name']}.#{$1}"
        next if File.exists? filename
        STDERR.puts "Downloading image: #{data} to #{filename}"
        begin
          File.open(filename, "wb") do |f|
            f.write open(data).read
          end
        rescue Exception => e
          STDERR.puts e
          next
        end
        hash['logo_file_name'] = filename
        hash['logo_file_size'] = File.size filename
        if filename =~ /jpe?g$/i
          hash['logo_content_type'] = 'image/jpeg'
        elsif filename =~ /gif$/i
          hash['logo_content_type'] = 'image/gif'
        elsif filename =~ /png$/i
          hash['logo_content_type'] = 'image/png'
        end
        hash['logo_updated_at'] = '2012-10-24 00:23:40'
      end
    end
  end
  hash.delete 'logo'
  next unless hash['email'] and hash['email'] =~ /\@/
  ap hash
  u = User.where(:email => hash['email']).first
  u = User.new unless u
  u.email = hash['email']
  hash.delete 'email'
  password = SecureRandom.urlsafe_base64(10)
  u.password = password
  u.password_confirmation = password
  u.save
  pass.puts [u.email, password].join("\t")
  b = Business.new
  hash.each_key do |key|
    next if key == nil
    b.send("#{key}=", hash[key])
  end
  b.user_id = u.id
  b.save :validate => false
end
