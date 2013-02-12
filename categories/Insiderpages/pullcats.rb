require 'nokogiri'
require 'open-uri'
require 'rest_client'
require 'json'
require 'watir-webdriver'

@browser = Watir::Browser.new
alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
alphabet2 = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
alphabet3 = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

file = File.open("category_first.txt", "w")

alphabet.each do |a|

alphabet2.each do |b|

alphabet3.each do |c|

param = a+b+c
url = "http://www.insiderpages.com/type_ahead_search?q="+param+"&model=CsCategory"
@browser.goto(url)
next if @browser.body.text == "[]"
html = @browser.body.text.gsub(":","=>")
html = eval(html)
html.each do |v|
name = v.to_s.scan(/"name"=>"(.*)"}/)
puts(name)
file.write(name.to_s + "\n") 
end




end
end
end

file.close unless file == nil



