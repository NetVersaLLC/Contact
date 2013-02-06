require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
url = 'http://webapp.localeze.com/directory/sign-up.aspx?UserAction=ADD#get-business/standard'
@browser = Watir::Browser.new
#@browser.maximize()
#@browser.speed = :slow

@browser.goto(url)
  
  @browser.link(:text => 'View List').click
  cats = []
  @browser.div(:class => 'controls alpha-list').links.each do |letter|
    letter.click
    sleep(2)
    
    @browser.ul( :class => 'nav nav-list').spans.each do |cat|
      puts(cat.text)
      cats.push(cat.text)
    end
    sleep(2)
  end
  
  
  
  

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close

