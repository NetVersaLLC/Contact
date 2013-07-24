#Version 0.0.2, Written by Kazyyk

require "watir-webdriver"
require "nokogiri"
require "open-uri"
require 'json'

#categories = Hash.new
#finalcats = Hash.new

puts("Initializing Bing Category Scraper...")
@browser = Watir::Browser.new
url = "https://www.bingplaces.com/DashBoard"
@browser.goto(url)
file = File.new("bingcategories.txt","w")
puts("Initialization complete.")

puts("Gaining access to categories...")
@browser.execute_script("hidePopUp()")
@browser.text_field(:name => 'PhoneNumber').when_present.set "7048394834"
@browser.execute_script("hidePopUp()")
@browser.button(:value => 'Search').click
@browser.execute_script("hidePopUp()")
@browser.button(:value, 'Create New Business' ).when_present.click
puts("Please click login. You have eight seconds.")
sleep(5)#@browser.link(:text, 'Login').when_present.click
sleep(3)
@browser.input( :name, 'login' ).send_keys "kovacekblick2728@outlook.com"
@browser.text_field( :name, 'passwd' ).send_keys "YPnGTrlLbE3iLg"
@browser.button( :name, 'SI' ).click
begin
Watir::Wait.until { @browser.text.include? "Enter your business details" }
rescue
	sleep(5)
end
@browser.link(:id, 'categoryTree').click
begin
Watir::Wait.until { @browser.text.include? "Browse Categories"}
rescue
	sleep(5)
end
puts("Categories access gained.")

puts("Scraping categories...")
count = 1
#search = /SelectCategoryFromTree\(this, '70000.'\)/
until count == 875
#@browser.elements(:css , "a[onclick='SelectCategoryFromTree']").each do |category|
@browser.div(:class, 'categoryTree').links.each do |category|
		begin
	puts(category.text)
	category.click
	next if category.text == ""
	file.write(category.text + "\n")
	count += 1
		rescue 
			puts("Categories scraped.")
			break
		end
end
puts("Something went wrong.")
end

#puts("Initiliazing Nokogiri...")
#url = @browser.url
#doc = Nokogiri::HTML(open(url))
#puts("Initialization complete.")

#search = /SelectCategoryFromTree\(this, '70000.'\)/
#doc.css("a[#{Regexp.quote(search)}]").each do |parent|
#doc.css("div.categoryTree a").each do |category|
	#next if category == ""
	#puts(category.text)
	#if not category == "" then
		#@browser.elements(:css, "SelectCategoryFromTree(this, '700001')").to_subtype.click
		#sleep(1)
		#doc.css(/ul#70000\..hideClass a/).each do |sub1|
		#next if sub1 == ""
		#puts(" > " + sub1.text)
		#if 


	#end
#end