#!/usr/bin/env ruby

require 'pp'
require './config/environment.rb'

business_id = ARGV.shift
payload     = ARGV.shift

b = Business.find(business_id)

if File.exists? payload
  Job.inject(b.id, File.open(payload, "r").read, 'Ping')
end
