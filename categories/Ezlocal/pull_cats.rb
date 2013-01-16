require 'nokogiri'
html = File.open("initiallist.html", "r")
nok = Nokogiri::HTML( html )
html.close unless html == nil

	file = File.open("categories.txt", "w")
	nok.xpath("//select/option").each do |texty|
		next if texty.inner_text == "-- Select Category --"
		file.write(texty.inner_text + "\n") 
	end
file.close unless file == nil
