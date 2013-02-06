require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new

@browser.goto('http://www.localizedbiz.com/login/login.php')
	@browser.text_field(:id => 'username').set "thedeskto7074"
	@browser.text_field(:id => 'password').set "v8nJtqFrfw"
	@browser.button( :name => 'Login').click
  
  @browser.goto('http://www.localizedbiz.com/add.php')
  
  sleep(5)
  PrimeCats = @browser.select_list( :name => 'biz_cat1').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
next if cat1 == "-- Choose a category below --"
		@browser.select_list( :name => 'biz_cat1' ).select cat1
		puts(cat1)
		sleep(1)
		temps = @browser.select_list( :name => 'biz_cat2').options.map(&:text)
		subCats[cat1] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
  