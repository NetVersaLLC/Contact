require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
	@browser.goto('http://www.localpages.com/signup/')
@browser.execute_script("
      oFormObject = document.forms['login'];
      oFormObject.elements['username'].value = 'arbitrarywords6192';
      oFormObject.elements['password'].value = '72iwdQf0KO';    
      ")

@browser.link( :text => 'Login').click


@browser.goto('http://www.localpages.com/add_edit_business_info.php')


finalCats = {}
@browser.select_list(:name => 'category_1').options.each do |option|

next if option.text =~ /- Please Select -/i
  puts(option.text)

  option.click
  sleep(2)

    subs = []
    @browser.select_list(:id => 'category_2').options.each do |td|
      next if td.text =~ /- Please Select -/i
      puts(" > " +td.text)
      
      subs.push td.text
    end
finalCats[option.text] = subs
  
end
  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close