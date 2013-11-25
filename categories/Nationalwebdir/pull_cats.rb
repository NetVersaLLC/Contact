require 'rest-client'
require 'nokogiri'


file = File.open("categories.txt","w")
url =  "http://nationalwebdirectory.net/add.php"
page = Nokogiri::HTML(RestClient.get(url))
page.xpath('//select[@name="category"]/option').each do |category|
	file.write(category.text + "\n")
	puts(category.text)
end