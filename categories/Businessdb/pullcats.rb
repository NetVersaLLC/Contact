require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
require 'rest_client'

@browser = Watir::Browser.new

seed = rand(20000).to_s

@browser.goto('http://www.businessdb.com/sign-up')
@browser.text_field(:name => 'password_again').set "adfadsfadsfads"
@browser.text_field(:name => 'password').set "adfadsfadsfads"
@browser.text_field(:name => 'company_name').set seed+" Business Awesome " +seed
@browser.select_list(:name => 'country_id').select "United States of America"
@browser.text_field(:name => 'email').set seed+"dasfadsfdasf@hotmail.com"
@browser.checkbox(:name=> 'agreement').set
@browser.link(:text=>'Sign Up FREE').click


#category_id

#category_id_1

#Select category

finalCats = {}

@browser.select_list(:id => 'category_id').options.each do |first|
next if first.text == "Select category"
  puts(first.text)
  first.click
  sleep 5
    subs = []
    next if not @browser.select_list(:id => 'category_id_1').exists?
    @browser.select_list(:id => 'category_id_1').options.each do |second|
      next if second.text == "Select category"
      puts(" > " +second.text)
      subs.push(second.text)
    end
  finalCats[first.text] = subs
end  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
