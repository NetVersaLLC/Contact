require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://www.digabusiness.com/submit.php" )

@browser.span( :id => 'toggleCategTree').click

sleep(5)
primaryCats = []
@browser.div( :id => 'categtree').divs.each do |rootcat|

puts(rootcat.text)
primaryCats.push(rootcat.text)
  

end

subCats = Hash.new()

primaryCats.each do |rootcat|
  @browser.div( :text => rootcat).click
  puts(rootcat)
  sleep(5)
  @browser.div( :id => 'categtree').divs.each do |subcat|
    next if subcat.title == "Reload category list from top."
    next if subcat.title == "Go one step back"    
    puts(" > " + subcat.text)
    
  end
  
  temps = @browser.div( :id => 'categtree').divs.map(&:text)
  temps.delete("Reload")
  temps.delete("..")
  subCats[rootcat] = temps
    
    
  @browser.div( :id => 'categtree').div( :title => 'Go one step back').click
  sleep(5)

 
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close


