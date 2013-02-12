require 'watir-webdriver'
require 'json'

url = 'http://www.ibegin.com/dialog/categories/?page=1&q=&calling_element_id=id_category1'
@browser = Watir::Browser.new
@browser.goto(url)
=begin
@browser.text_field( :name => 'name').set "arbitrarywords6192@hotmail.com"
@browser.text_field( :name => 'pw').set "2ezufzHW_3QF"
@browser.button( :value => /Login/).click
=end
sleep(5)



	file = File.open("categories.txt", "w")
more = true
for i in 2..1054
  @browser.trs(:class => 'row1').each do |row|
    file.write(row.td.link.text + "\n")
    puts(row.td.link.text)
  end
  url = "http://www.ibegin.com/dialog/categories/?page=#{i}&q=&calling_element_id=id_category1"
  @browser.goto(url)
end

file.close unless file == nil