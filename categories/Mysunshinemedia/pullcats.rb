require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new


@browser.goto("http://www.mysunshinemedia.com/directory/LA")

pages = @browser.tr(:xpath => '/html/body/div[4]/div[3]/table/tbody/tr').links
thepages = []
pages.each do |url|
	thepages.push(url.attribute_value("href"))
end
cats = []
thepages.each do |url|

	@browser.goto(url)

	@browser.table(:xpath => '//*[@id="content_container_white"]/table').links.each do |cat|
		puts(cat.text)
		cats.push(cat.text)
	end
end


cats = cats.uniq

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
