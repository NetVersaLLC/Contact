require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'


@browser = Watir::Browser.new
@browser.goto("https://www.facebook.com/pages/create/?ref_type=sitefooter")

cats = []
@browser.select_list(:name => 'category').options.each do |cat|
	next if cat.text == "Choose a category"
	puts(cat.text)
	cats.push(cat.text)

end

cats = cats.uniq

finalCats = cats.to_json
fJson = File.open("profile_categories.json","w")
fJson.write(finalCats)
fJson.close