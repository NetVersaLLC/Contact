#!/usr/bin/env ruby
# encoding utf-8

require './config/environment'
require './account_creator/vitelity'

v = Vitelity.new('netv_jon', 'hotfiya6!')

vitelity_number = VitelityNumber.where (:business_id => ARGV.shift ).first

response = v.callfw( {:did => number, :forward => ARGV.shift }).first 
ap response

vitelity_number.save!
