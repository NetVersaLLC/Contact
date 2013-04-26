require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://spotabusiness.com/Create-an-account.html" )

cats = []

@browser.select_list( :name => 'cb_businesscategory').options.each do |option|
  next if option.text == "None"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


