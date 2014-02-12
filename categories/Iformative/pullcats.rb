require 'nokogiri'
require 'open-uri'
require 'json'

categories = []
url = 'http://www.iformative.com/review/request'
categories = Nokogiri::HTML(open url).css('select[name=category] option').map &:text
file = File.open("categories.json","w")
file.write categories.to_json
file.close
