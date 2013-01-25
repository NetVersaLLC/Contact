require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://primeplace.nokia.com/place/create" )

PrimeCats = @browser.select_list( :name => 'level1Category').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
next if cat1 == ""
next if cat1 == "Select from list"
		@browser.select_list( :name => 'level1Category' ).select cat1
		puts(cat1)
		sleep(1)
		temps = @browser.select_list( :id => 'level3Category').options.map(&:text)
		subCats[cat1] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
