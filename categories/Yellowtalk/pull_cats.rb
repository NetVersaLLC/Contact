require 'watir-webdriver'

@browser = Watir::Browser.new #Browser launch
@browser.goto( "http://yellowtalk.com/businessFreeAdd.php" ) # Navigating to the URL
PrimeCats = @browser.select_list( :name => 'category[0]').options.map(&:text) # Catching the list of options from the drom down list.

#Creating a json file using the options already storead at above variable PrimeCats....
finalCats = PrimeCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close	

@browser.close
exit