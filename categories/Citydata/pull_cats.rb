require 'nokogiri'
require 'rest-client'
require 'json'


nok = Nokogiri::HTML(RestClient.get 'http://www.city-data.com/profiles/add')

cats = []

nok.xpath("//select[@name ='cat']/option").each do |option|
  next if option.text == "----------------------------------------------"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


