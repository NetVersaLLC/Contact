require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
puts 'Loading Signin Page for Localdatabase.com'
@browser.goto('http://www.localdatabase.com/users/?login')

puts 'Signin to your Localdatabase.com account'

@browser.div(:class => 'blindbox').text_field(:name, "vb_login_username").set "arbitrarywords61929"
@browser.div(:class => 'blindbox').text_field(:name, "vb_login_password").set "ulOcKHL8"
@browser.div(:class => 'blindbox').button(:text => 'Log In').click    
sleep(2)
Watir::Wait.until {@browser.text.include? 'Logout'}
  
puts 'Signin is Completed'

@browser.goto("http://www.localdatabase.com/users/?do=business&what=addlisting")

#@browser.maximize()
#@browser.speed = :slow


finalCats = {}
@browser.select_list(:name => 'addcategory').options.each do |option|

next if option.text =~ /Choose A Category/
  puts(option.text)

  option.click
  sleep(2)

    subs = []
    @browser.table(:id => 'subcatlist').tds.each do |td|
      puts(" > " +td.text)
      break if td.text =~ /There are no subcategories for category at this time/i
      subs.push td.text
    end
finalCats[option.text] = subs
  
end
  
  
finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close