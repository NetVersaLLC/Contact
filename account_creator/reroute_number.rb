#!/usr/bin/env ruby
# encoding utf-8

require './config/environment'
require 'vitelity'

v = Vitelity.new('netv_jon', 'hotfiya6!')

vitelity_number = VitelityNumber.where (:business_id => ARGV.shift ).first

destination = ARGV.shift

response = v.callfw( {:did => vitelity_number.did, :forward => destination  }).first 
ap response

vitelity_number.forwards_to = destination
vitelity_number.save!
