#!/usr/bin/env ruby

require 'awesome_print'
require './config/environment.rb'

site                = ARGV.shift
data                = {}
data['business']    = 'ListingApe'
data['phone']       = '888-6000-APE'
data['zip']         = '92780'
data['latitude']    = 33.6650
data['longitude']   = 117.9122
data['state']       = 'Tustin'
data['state_short'] = 'CA'
data['city']        = 'Costa Mesa'
data['county']      = 'Orange'
data['country']     = 'USA'

results,status,error_message = Scan.make_scan(data, site)

ap results
ap status
ap error_message
