require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new

@browser.goto( 'https://business.angieslist.com/Registration/Registration.aspx' )
@browser.text_field(:id => /CompanyName/).set "dasfdasfdasdfdasfasdfasdfasdf"
@browser.text_field(:id => /CompanyZip/).set "66224"
@browser.image(:alt,'Search').click
sleep(5)
@browser.image(:alt,'Add Company').click
sleep(3)

cats = []
@browser.select_list( :name => /leftlstbox/).options.each do |option|
  next if option.text == "none one"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close