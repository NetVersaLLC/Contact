require 'open-uri'
require 'nokogiri'
require 'watir'
require 'json'

url = "http://www.shopinusa.com/signup/"
@browser = Watir::Browser.new
@browser.goto( url )

allNames = []

table = @browser.table( :id => 'ctl00_MainContent_ctlCategories_primary_catDataList')
	table.rows.each do |row|
		row.cells.each do |cell|
		next if cell.text == ""
			allNames.push(cell.text)
		end
	end


finalCats = Hash.new()

allNames.each do |name|
subNames = []
puts(name)
	@browser.link( :text => name ).click
	sleep(5)
	table = @browser.table( :id => 'ctl00_MainContent_ctlCategories_primary_subCatDataList')
	
	table.rows.each do |row|
		row.cells.each do |cell|
		next if cell.text == ""
			puts(" >> " + cell.text)
			subNames.push(cell.text)			
		end

	end
		finalCats[name] = subNames
		@browser.goto( url )	
end

finalCats = finalCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close



