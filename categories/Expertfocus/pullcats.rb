require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://exportfocus.com/free-business-directory-listing1.php" )

cats = []

@browser.select_list( :name => 'industry').options.each do |option|
  next if option.text == "select one"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


