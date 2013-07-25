require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "www.facebook.com" )
	@browser.goto("https://www.facebook.com/")
	@browser.text_field(:name => 'email').set "stiedemanngroup10071@outlook.com"
	@browser.text_field(:name => 'pass').set "XqoT6ZROOb7qC6E"
	@browser.button(:value => 'Log In').click

sleep 5
@browser.goto("https://www.facebook.com/pages/edit/?id=111110865762574&sk=basic")

@thetextfield = @browser.text_field(:value => 'What type of place is this?')

cats = []
('aa' .. 'zz').each do |q|
	@thetextfield.set q
	sleep(3)
		if @browser.ul(:id => /typeahead_list/).exists?
		@browser.ul(:id => /typeahead_list/).lis.each do |cat|
			puts(cat.text)
			cats.push(cat.text)
		end	
	end
end

cats = cats.uniq

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close