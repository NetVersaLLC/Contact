#!/usr/bin/env ruby
# encoding: utf-8

require './config/environment'
require 'vitelity'

v = Vitelity.new('netv_jon', 'hotfiya6!')

vitelity_number = VitelityNumber.where( :business_id => ARGV.shift ).first

response = v.removedid( {:did => vitelity_number.did } )
ap response

vitelity_number.active = false
vitelity_number.save!
