require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto("http://www.shopcity.com/map/mapnav_locations.cfm?")

@browser.link( :text => /United States/).click
@browser.link( :text => /Kansas/).click
@browser.link( :text => /Leawood/).click	

@browser.link( :title => 'Login').click
@browser.text_field( :name => 'email').set "netversatest74@yahoo.com"
@browser.text_field( :name => 'pw').set "nhaaenia"

@browser.link( :title => 'Sign Me In').click

@browser.link( :title => 'Add Business').click

@browser.link( :class => 'linkMarketButton').click

seed = (1000..2000).to_a.sample.to_s

@browser.text_field( :id => 'subfolder_name').set "testsiteofdoom"+seed


sleep(3)
@browser.link( :title => 'GET STARTED!').click

if @browser.alert.exists?
	@browser.alert.ok
end


@browser.text_field( :name => 'businessname').when_present.set "TestBusiness" + seed
@browser.text_field( :name => 'contact').set "asdf asdf"
@browser.text_field( :name => 'address1').set seed + "Happy Streety"
@browser.text_field( :name => 'city').set "Leawood"
@browser.text_field( :name => 'province').set "Kansas"
@browser.text_field( :name => 'country').set "USA"
@browser.text_field( :name => 'postal').set "66224"
@browser.text_field( :name => 'phone').set "4566541236"
@browser.text_field( :name => 'email').set "netversatest74@yahoo.com"
@browser.checkbox( :name => 'agree').click

@browser.button( :value => /Next/).click

sleep(5)

PrimeCats = @browser.select_list( :name => 'MainCategories').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
next if cat1 == ""
		@browser.select_list( :name => 'MainCategories' ).select cat1
		puts(cat1)
		sleep(1)
		temps = @browser.select_list( :name => 'SelectList').options.map(&:text)
		subCats[cat1] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close









