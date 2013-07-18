require 'watir-webdriver'


@browser = Watir::Browser.new

	@browser.goto("https://foursquare.com/login")
	@browser.text_field(:id => 'username').set "jwnetversa@gmail.com"
	@browser.text_field(:id => 'password').set "ocean74"

	@browser.button(:value => 'Log in').click

	sleep 2
	Watir::Wait.until { @browser.text.include? "Find great places on the go." }

	@browser.goto("https://foursquare.com/add_venue?")

finalCats = {}
@browser.select_list(:name => 'topLevelCategory').options.each do |first|
next if first.text == "Select a category"
  puts(first.text)
  first.click
  sleep 5
    subs = []
    next if not @browser.select_list(:name => 'secondLevelCategory').exists?
    @browser.select_list(:name => 'secondLevelCategory').options.each do |second|
      next if second.text == "Select a category"
      puts(" > " +second.text)
      subs.push(second.text)
    end
  finalCats[first.text] = subs
end  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
