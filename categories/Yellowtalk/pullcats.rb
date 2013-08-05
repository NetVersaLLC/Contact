require 'nokogiri'
require 'rest-client'

file = File.open("categories.txt","w")

page = Nokogiri::HTML(RestClient.get("http://yellowtalk.com/businessFreeAdd.php"))
page.xpath('//select[@name="category[0]"]/option').each do |category|
	file.write(category.text + "\n")
	puts(category.text)
end

#### Alternative Method ####
# file = File.open("categories.json","w")
# page = Nokogiri::HTML(RestClient.get("http://yellowtalk.com/businessFreeAdd.php"))
# cats = page.xpath('//select[@name="category[0]"]/option').map(&:text)
# file.write(cats.to_json)