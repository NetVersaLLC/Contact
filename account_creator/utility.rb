#!/usr/bin/env ruby

require 'rubygems'
require 'sdbm'
require 'date'
require 'yaml'
require 'awesome_print'
require './account_creator/vitelity'

module Utility

  def self.get_ratecenter
    v = Vitelity.new('netv_jon', 'hotfiya6!')
    response = v.listavailstates
    states = response['content']['states']['state']
    state = states[ rand(states.length) ]
    response = v.listavailratecenters( {:state => state} )
    ratecenters = response['content']['ratecenters']['rc']
    ratecenter = ratecenters[ rand( ratecenters.length ) ]
    return [ratecenter, state]
  end

  def self.get_number
    v = Vitelity.new('netv_jon', 'hotfiya6!')
    ratecenter = self.get_ratecenter
    ap ratecenter
    print "Use this?: "
    answer = gets
    unless answer =~ /[Yy]/
      exit
    end
    response = v.listlocal( { :state => ratecenter[1], :ratecenter => ratecenter[0] } )
    numbers = response['content']['numbers']['did']
    number = numbers[ rand( numbers.length ) ]
    return number
  end

  def self.order_number( number )
    v = Vitelity.new('netv_jon', 'hotfiya6!')
    response = v.getlocaldid( { :did => number } )
    if response['content']['status'] == 'ok'
      destination = '5735292536'
      STDERR.puts "Ordered Number: #{number}!"
      STDERR.puts "Forwarding to: #{destination}!"
      v.callfw( { :did => number, :forward => destination } )
      return true
    else
      return false
    end
  end

  def self.get_address( number )
    # ywsid = 'IRRAQuDAiFqFCPGrPzyA3Q'
    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
     :term    => 'cable provider',
     :city => number['ratecenter'],
     :state => number['state'],
     :location => "#{number['ratecenter']}, #{number['state']}",
     :consumer_key => 'guxExEGc6q_CGmo8Xv44Bg',
     :consumer_secret => 'oxYRwyMK7jL2zVrMUjINlVti914',
     :token => '-neQfJo0y6Ie_mHaR_jq7UfiC2SHZPXN',
     :token_secret => '-8ruinaW1nedbv7fxTJ3d7NAihE'
    )
    response = client.search(request)
    # response = YAML::load_file('request.yml')
    f = File.open("request.yml", 'w')
    YAML::dump(response, f)
    business_hash = {}
    response['businesses'].each do |business|
      business_hash['address'] = response["businesses"][0]['location']["address"].join(" ")
      business_hash['city']    = response["businesses"][0]['location']["city"]
      business_hash['state']   = response["businesses"][0]['location']["state_code"]
      business_hash['zip']     = response["businesses"][0]['location']["postal_code"]
      break
    end
    business_hash
  end

  def self.company_faker
    identifier = ['Universal', 'Western', 'Pacific', 'Transmit', 'Standard', 'Core', 'Velocity', 'Hyper']
    components = ['Cable', 'Wire', 'Satellite', 'Fiber', 'VOIP']
    type = ['Company', 'Communications', 'Solutions', 'Access', 'Exchange', 'Authority', 'Group']

    returned_names = [ identifier[rand(identifier.length).to_i] ]
    if (rand * 10).to_i > 5
      returned_names.push identifier[rand(identifier.length).to_i]
    end
    returned_names.push components[rand(components.length).to_i]
    returned_names.push type[rand(type.length).to_i]
    return returned_names.join(" ")
  end

  def self.get_fake_name
    SDBM.open("names.dbm") do |names|
      name = self.company_faker
      unless names[name]
        names[name] = 'true'
        return name
      end
    end
  end

  def self.generate_random_year
    founded_year = rand(1950...2013)
    weight = rand(10)
    founded_year += rand(10...30) if weight > 5 && founded_year < 1983 
    founded_year
  end

  def self.get_new_password
    password = ''
    1.upto(10).each {|v| password += ('a' .. 'z').to_a[rand*26]}
    password += (rand * 1000).to_i.to_s
  end

  def self.generate_birthday
    birthday_year = 1940 + rand(40)
    birthday_month = rand(12)
    birthday_day = rand(28)
    birthday = DateTime.new(birthday_year, birthday_month, birthday_day).to_time.strftime('%m/%d/%Y')
  end

end
