require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto("https://adsolutions.yp.com/listings/basic")

cats = []

	file = File.open("categories.txt", "w")

('aaa' .. 'zzz').each do |q|

	@browser.text_field(:id => 'txtCategories').set q
	sleep(1)
	next if @browser.ul(:xpath => '/html/body/ul').lis.size == 0
	@browser.ul(:xpath => '/html/body/ul').lis.each do |cat|
		next if cat.text == ""
		puts(cat.text)
		file.write(cat.text + "@") 
	end
end

file.close unless file == nil
