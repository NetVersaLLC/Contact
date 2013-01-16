require 'nokogiri'
require 'watir'

@browser = Watir::Browser.new
@browser.goto( 'http://www.snoopitnow.com/Create-new-item.html' )

thecats = []
#
"abcdefghijklmnopqrstuvwxyz".split("").each do |i|
  @browser.text_field( :id => 'test_catinput').set i
  sleep(2)

  if @browser.ul(:xpath => "//ul[@id='as_ul']").exists?
	nok = Nokogiri::HTML( @browser.html )
	
	nok.xpath("//ul[@id='as_ul']/li/a/span[3]").each do |texty|
		thecats.push(texty.inner_text)
	end
  end
sleep(1)
  
  
  
  
end
  file = File.open("categories.txt", "w")
  thecats.each do |item|
		file.write(item + "\n") 
	end
  file.close unless file == nil

	
