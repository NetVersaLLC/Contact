#!/usr/bin/env ruby
require 'awesome_print'
require './config/environment.rb'
require 'csv'

csv = CSV.open("user_download_report.csv", "w")
File.open("passwords_for_users.txt", "r").each do |line|
  email,pass = *line.strip.split("\t")
  STDERR.puts "Working on: #{email}"
  u = User.where(:email => email).first
  b = Business.where(:user_id => u.id).first
  row = [email, pass,"https://dl.splatr.com/downloads/#{b.id}?auth_token=#{u.authentication_token}"]
  ActiveRecord::Base.connection.execute("DESC businesses").each do |cols|
    row.push b.send(cols[0])
  end
  csv << row
end

