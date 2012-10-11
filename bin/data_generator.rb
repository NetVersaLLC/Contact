#!/usr/bin/env ruby

require 'awesome_print'
require './config/environment.rb'

business_id = ARGV.shift
name        = ARGV.shift

b = Business.find(business_id)

STDERR.puts "Examining: #{name}"
business = Business.find( business_id )
payload  = Payload.start(name)
if payload.data_generator.nil?
  STDERR.puts "Data Generator is nil"
else
  ap eval payload.data_generator
end
