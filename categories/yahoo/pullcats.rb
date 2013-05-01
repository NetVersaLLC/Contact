require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto("https://login.yahoo.com/config/login?")

@browser.text_field(:id => 'username').set "wonder_frank"
@browser.text_field(:id => 'passwd').set "ojmt0t9EvfA"

@browser.button(:id => '.save').click

sleep 5
@browser.goto("http://beta.listings.local.yahoo.com")


cats = []
"aeuo".split("").each do |v|
('aa' .. 'zz').each do |q|
	query = q.split("")[0] + v + q.split("")[1]
	@browser.text_field(:id => 'acseccat1').set query
	sleep(3)

	@browser.ul(:class => /yui3-aclist-list/).lis.each do |cat|
		puts(cat.text)
		cats.push(cat.text)

	end	
end
end
cats = cats.uniq

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close