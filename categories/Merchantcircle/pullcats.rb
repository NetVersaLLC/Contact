require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
@browser = Watir::Browser.new
  @browser.goto("https://www.merchantcircle.com/auth/login?")

  @browser.text_field(:id => 'email').set "arbitrarywords6192@hotmail.com"
  @browser.text_field(:id => 'password').set "KU4Nq2dtOc_Y4w"

  @browser.button(:name => 'submit').click

@browser.goto('http://www.merchantcircle.com/merchant/category')


finalCats = {}
@browser.select_list(:id => 'levelone').options.each do |first|

next if second.text =~ /-- None --/i
  puts(second.text)

  second.click
  sleep(2)

    subs = []
    @browser.select_list(:id => 'leveltwo').options.each do |second|
      next if second.text =~ /-- None --/i
      puts(" > " +second.text)

      @browser.select_list(:id => 'levelthree').options.each do |third|
        puts(" > > "+third.text)

      end


      
      subs.push td.text
    end
  
end
  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close