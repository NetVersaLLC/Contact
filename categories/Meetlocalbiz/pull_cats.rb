require 'nokogiri'
require 'rest-client'
require 'json'


nok = Nokogiri::HTML(RestClient.get 'http://meetlocalbiz.com/join/biz/plan/')

cats = []

nok.xpath("//select[@name ='category_id']/option").each do |option|
  next if option.text == "--- Please Choose ---"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


