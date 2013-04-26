require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
require 'rest_client'

@browser = Watir::Browser.new

cats = []

alpha = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
alpha.each do |param|

  url = "http://www.zipperpages.com/directoryservices.html?letter=#{param}"
  @browser.goto(url)

  noksub = Nokogiri::HTML(@browser.html)

  noksub.css("a.RecNav-Data").each do |links|
  puts (links.text)
  cats.push(links.text)
end
end


finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
