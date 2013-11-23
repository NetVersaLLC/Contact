#!/usr/bin/env ruby

require 'mechanize'
require 'awesome_print'
require 'rest_client'
require 'nokogiri'
require 'json'

agent = Mechanize.new
agent.get("http://www.bizhwy.com/search_type.php")
options = []
agent.page.form.fields[0].options.each do |opt|
  options.push opt.text
end
options.shift
options.shift

final = {}
options.each do |category|
  puts "Posting: #{category}"
  page = RestClient.post "http://www.bizhwy.com/search_type.php", {:category => category}
  nok = Nokogiri::HTML( page )
  nok.xpath("//option").each do |option|
    value = option.attr('value')
    next if value == 'select'
    puts "Setting: #{value}"
    if final.has_key? category
      final[category].push value
    else
      final[category] = [value]
    end
  end
  sleep 1
end

File.open("categories.json", "w").write final.to_json
