require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://www.cornerstonesworld.com/index.php?page=addurl" )

cats = []

@browser.select_list( :name => 'cat').options.each do |option|
  next if option.text == "none one"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


