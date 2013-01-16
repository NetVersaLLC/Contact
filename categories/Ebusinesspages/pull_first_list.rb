require 'nokogiri'
require 'open-uri'
require 'rest_client'

#http://ebusinesspages.com/ajaxLookup.aspx?CatLookup=1&sCatTitle=zoo

file = File.new("ultimate_category_list.txt", "r")
saveFile = File.new("first_pass.txt", "w")
count = 0
while (line = file.gets)
		url = URI.escape("http://ebusinesspages.com/ajaxLookup.aspx?CatLookup=1&sCatTitle=" + line)
		html = open(url).read
		links = html.split("<br/>")
		links.each do |alink|
			nok = Nokogiri::HTML( alink )
			cat = nok.xpath("//a").last
			cat = cat.inner_html
			#saveFile.write(cat + "\n") 
		end
		sleep(3)
		puts(count)
		count = count + 1
	
end
count("Annnddd we're done!")
saveFile.close
file.close


#<a href='javascript:void(0);' onclick='CatSelect("Manufacturing","7pw");'>Manufacturing</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href='javascript:void(0);' onclick='CatSelect("Miscellaneous Manufacturing Industries","aqu");'>Miscellaneous Manufacturing Industries</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href='javascript:void(0);' onclick='CatSelect("Signs and Advertising Specialties","aud");'>Signs and Advertising Specialties</a>&nbsp;&nbsp;>&nbsp;&nbsp;<b><a href='javascript:void(0);' onclick='CatSelect("Electric signs","aue");'>Electric signs</a></b><br/>

