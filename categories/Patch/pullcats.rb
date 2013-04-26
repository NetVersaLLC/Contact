require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'
require 'rest_client'
=begin
@browser = Watir::Browser.new
#html = RestClient.get 'http://romeoville.patch.com/directory'
#nok = Nokogiri::HTML(html)
@browser.goto("http://romeoville.patch.com/directory")

roots = []

@browser.links(:href => /\/directory\/category\//).each do |cat|
next if cat.text == ""
    #puts(cat.text)
    roots.push(cat.text)
end
=end
html = RestClient.get 'http://shakerheights.patch.com/listings#modal_dialog:ugc_listing_modal_dialog'
nok = Nokogiri::HTML(html)

finalCats = {}

nok.css("ul.nested_categories.no-margin").each do |root|
  puts(root.parent.css("label")[0].text)

  rootName = root.parent.css("label")[0].text
  subs = []
  root.css("label").each do |sub|
    puts(" > "+sub.text)
    subs.push(sub.text)
  end
finalCats[rootName] = subs
end






finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
