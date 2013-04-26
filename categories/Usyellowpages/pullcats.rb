require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto("http://www.usyellowpages.com/")

@browser.link(:text => 'Create a Free Listing').click

cats = []
('aa' .. 'zz').each do |q|
	@browser.text_field(:id => 'FilterHeadings').set q
	sleep(3)

	@browser.divs(:id => /search/).each do |cat|
		puts(cat.text)
		cats.push(cat.text)

	end	
end

cats = cats.uniq

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close