#!/usr/bin/env ruby

require 'pp'
require './config/environment.rb'

user_id     = ARGV.shift
business_id = ARGV.shift
payload     = ARGV.shift

u = User.find(user_id)
b = Business.find(business_id)

if b.user_id != u.id
  STDERR.puts "User does not own business!"
  exit
end

if File.exists? payload
  Job.inject(b.id, File.open(payload, "r").read, 'Ping')
end
