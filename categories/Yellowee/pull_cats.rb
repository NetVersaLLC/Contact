require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://biz.yellowee.com/steps/add-your-business?what=dfsgdfgdfg&where=66224" )
@browser.text_field( :name => 'username').set "netversatest74@yahoo.com"
@browser.text_field( :name => 'password').set "nhaaenia"
@browser.button( :value => 'Login').click

sleep(3)

PrimeCats = @browser.select_list( :name => 'category1_1').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
next if cat1 == ""
		@browser.select_list( :name => 'category1_1' ).select cat1
		puts(cat1)
		sleep(1)
		temps = @browser.select_list( :name => 'category1_2').options.map(&:text)
		subCats[cat1] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close

