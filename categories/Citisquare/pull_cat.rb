require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://my.citysquares.com/signup/free" )
@browser.text_field( :name => 'name').set "netversatest74@yahoo.com"
@browser.text_field( :name => 'pass').set "password1"
@browser.button( :value => 'Log In').click

PrimeCats = @browser.select_list( :name => 'top_cat').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
next if cat1 == ""
		@browser.select_list( :name => 'top_cat' ).select cat1
		puts(cat1)
		sleep(1)
		temps = @browser.select_list( :name => 'inet_cat').options.map(&:text)
		subCats[cat1] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close








