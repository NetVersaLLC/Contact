#!/usr/bin/env ruby

require 'pp'
require './config/environment.rb'

business_id = ARGV.shift
name    = ARGV.shift

b = Business.find(business_id)
payload = Payload.start(name)
if payload == nil
  puts "Not found!"
  exit
end

@job = Job.inject(business_id, payload.payload, payload.data_generator, payload.ready)
@job.name = name
@job.save
