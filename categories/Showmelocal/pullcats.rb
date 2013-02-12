require 'watir-webdriver'
require 'json'

url = 'http://www.showmelocal.com/businessregistration.aspx'
@browser = Watir::Browser.new
@browser.goto(url)

cats = []
@browser.select_list( :name => /_ctl7:cboCategory/).options.each do |option|
  cats.push(option.text)
  puts(option.text)
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close