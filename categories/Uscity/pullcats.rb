require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new
@browser.goto("http://uscity.net/register")

cats = []
alpha = "abcdefghijklmnopqrstuvwxyz".split("")
alpha.each do |a|
	@browser.text_field(:name => 'category_name[]').set a
	sleep(5)
	next if @browser.div(:class => 'suggestionList').text =~ /Nothing found./i
	subs = @browser.ul(:xpath => '//*[@id="categorySuggestions_0List"]/ul').lis
	subs.each do |s|
		puts(s.text)
		cats.push(s.text)
	end
end

finalCats = cats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close
