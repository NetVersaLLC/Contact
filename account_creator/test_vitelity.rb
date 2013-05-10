#!/usr/bin/env ruby
# encoding: utf-8

require './vitelity'


v = Vitelity.new('netv_jon', 'hotfiya6!')

response = v.listavailratecenters( {:state => 'CA'} )

ap response
