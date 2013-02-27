#!/usr/bin/env ruby

require './config/environment.rb'

@scan = Scan.new(ARGV.shift, ARGV.shift, ARGV.shift)
STDERR.puts @scan.run().to_json
