require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
@browser = Watir::Browser.new
  @browser.goto("http://mojopages.com/login")
  @browser.text_field(:name => 'username').set "arbitrarywords6192@hotmail.com"
  @browser.text_field(:name => 'password').set "nhaaenia"
  @browser.button(:value => 'Login').click

sleep 3  #wait for login to process
@browser.goto("http://mojopages.com/business/")
sleep 2 
Watir::Wait.until {@browser.div(:id => 'freeAdvertisingPopup-modal-panel').exists? or @browser.div(:id => 'dashboard_business_info').exists?}

if @browser.checkbox(:name => 'dontShowAgain').exists?
  @browser.checkbox(:name => 'dontShowAgain').click
end
sleep 2
@browser.link(:text => 'Edit Business Profile').click

sleep 1
Watir::Wait.until {@browser.h3(:id => 'biz_details_title').exists? }



finalCats = {}
@browser.select_list(:id => 'topCats').options.each do |first|
next if first.text =~ /Select Main Category/i
  puts(first.text)
  first.click
  sleep 5
    subs = []
    thesecond = {}
    @browser.div(:id => 'internetCats').select_list.options.each do |second|
      next if second.text =~ /Select Sub Category/i
      puts(" > " +second.text)
      second.click
      sleep 5
      thethird = []
        @browser.select_list(:name => 'category').options.each do |third|
          next if third.text =~ /Select Sub Sub Category/i
          puts(" > > "+third.text)
          thethird.push third.text
        end
        thesecond[second.text] = thethird         
    end
  finalCats[first.text] = thesecond
end
  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close