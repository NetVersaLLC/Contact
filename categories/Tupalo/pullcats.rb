require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
@browser = Watir::Browser.new
@browser.goto('http://tupalo.com/en/accounts/sign_in')
@browser.text_field(:id, "account_email").set "therailsbar5189@hotmail.com"
@browser.text_field(:id, "account_password").set "2a53cdcc"
  
  @browser.button(:value,"Sign in").click

  Watir::Wait.until {@browser.li(:id, "navUserNavigation").exists?}

@browser.goto("http://tupalo.com/en/spots/new")

finalCats = {}
@browser.select_list(:xpath => '//*[@id="spot_category_input"]/select[1]').options.each do |first|
next if first.text == ""
  puts(first.text)
  first.click
  sleep 5
    subs = []
    next if not @browser.select_list(:id => 'sublevel_category').exists?
    @browser.select_list(:id => 'sublevel_category').options.each do |second|
      next if second.text == ""
      puts(" > " +second.text)
      subs.push(second.text)
    end
  finalCats[first.text] = subs
end  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close