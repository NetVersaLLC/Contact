require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto('https://providers.matchpoint.com/register.htm')

cats = []

@browser.select_list( :name => 'industryId').options.each do |option|
  next if option.text == "- Select -"
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


