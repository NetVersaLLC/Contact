require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "https://www.staylocal.org/node/add/business-listing" )

cats = []

@browser.select_list( :name => 'taxonomy[4]').options.each do |option|
  next if option.text == "- Please choose -"
  theoption = option.text.gsub("-","")
  cats.push(theoption)
  puts(theoption)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


