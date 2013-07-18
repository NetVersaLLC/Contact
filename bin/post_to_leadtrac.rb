#!/usr/bin/env ruby

require 'rubygems'
require 'net/http'

uri = URI('http://reports.savilo.com/TownCenter/leads.php')
res = Net::HTTP.post_form(uri, {:phone => '573-529-2536', :zip => '92626', :business_name => 'HiPy Ltd.'})
puts res.body
