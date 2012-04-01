#!/usr/bin/env ruby

require 'find'

Find.find('app/views') do |f|
  next unless f =~ /\.erb$/
  puts "Converting #{f}..."
  `html2haml -rx #{f} #{f.gsub(/\.erb$/, '.haml')}`
  File.unlink f
end
