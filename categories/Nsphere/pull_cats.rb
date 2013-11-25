#!/usr/bin/env ruby

require 'awesome_print'
require 'open-uri'
require 'nokogiri'
require 'json'

page = Nokogiri::HTML(open("http://register.nsphere.net/Register.aspx"))
final = []
options = page.css("select")[0].css("option")
options.shift
options.pop
options.each do |category|
  category = category.text
  puts "Setting: #{category}"
  final.push category
end
File.open("categories.json", "w").write final.to_json
puts final
