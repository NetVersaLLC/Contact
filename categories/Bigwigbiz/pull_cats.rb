require 'rest-client'
require 'nokogiri'
require 'json'


file = File.open("categories.txt","w")
url =  "http://www.bigwigbiz.com"
page = Nokogiri::HTML(RestClient.get(url))
page.xpath('//select[@name="sub_cat"]/option').each do |category|
	file.write(category.text + "\n")
	puts(category.text)
end