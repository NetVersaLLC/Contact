require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto( "http://www.supermedia.com/spportal/quickbpflow.do" )


@browser.text_field( :name => 'phone').set "4563211239"
sleep(3)
@browser.link( :id => 'getstarted-search-btn' ).click
sleep(1)
@browser.link( :text => 'select').click
sleep(1)
@browser.span( :text => 'next').click

file = File.new("ultimate_category_list.txt", "r")
saveFile = File.new("first_pass.txt", "w")
count = 0
while (line = file.gets)
		
    
    @browser.text_field( :id => 'searchtext').set line
    @browser.link( :text => 'search').click
    sleep(5)
    next if @browser.text.include? "Sorry, we didn't find any category results."
    @browser.tbody( :id => 'fromDisplay').tr.td.divs.each do |result|
      puts(result.text.gsub("add >", ""))
        saveFile.write(result.text.gsub("add >", "")) 
    end
    
    puts(count)
		count = count + 1
	
end

saveFile.close
file.close

