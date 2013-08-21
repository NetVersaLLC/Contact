#!/usr/bin/env ruby

require 'awesome_print'
require './config/environment.rb'

site                = ARGV.shift
data                = {}
data['business']    = 'Ramen Yamadaya'
data['phone']       = '(714) 556-0091'
data['zip']         = 92626
data['latitude']    = 33.6650
data['longitude']   = 117.9122
data['state']       = 'California'
data['state_short'] = 'CA'
data['city']        = 'Costa Mesa'
data['county']      = 'Orange'
data['country']     = 'USA'

results,status,error_message = Scan.make_scan(data, site)

ap results
ap status
ap error_message
