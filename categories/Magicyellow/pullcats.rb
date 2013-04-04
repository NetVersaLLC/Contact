require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto('http://www.magicyellow.com/category_list/a.html')


alpha = "BCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
cats = []
alpha.each do |letter|
	@browser.links(:class => 'category').each do |cat|
		puts(cat.text)
		cats.push(cat.text)
	end
@browser.link(:text => letter).click
sleep(5)

end
finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close