require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
require 'rest_client'

@browser = Watir::Browser.new
@browser.goto("http://www.findthebest.com/category")
nok = Nokogiri::HTML(@browser.html)

cats = []

nok.css("a.show-all").each do |link|
	puts(link['href'])

	@browser.goto(link['href'])

	noksub = Nokogiri::HTML(@browser.html)

	noksub.css("div.clearfix.subcat_list").css("a").each do |links|
		puts(links.text)
		cats.push(links.text)

	end

end


finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
