require 'nokogiri'
require 'watir'

@browser = Watir::Browser.new
@browser.goto( 'http://www.localcensus.com/add_business.php' )

nok = Nokogiri::HTML( @browser.html )

file = File.open("categories.txt", "w")

nok.xpath("//select[@name='business_category']/option").each do |texty|
	next if texty.inner_text == 'Select Business Category'
	file.write(texty.inner_text + "\n") 
end

file.close unless file == nil

