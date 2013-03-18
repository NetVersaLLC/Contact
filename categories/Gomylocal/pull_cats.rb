require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new

url = 'https://www.gomylocal.com/add_listings.php?action=register&option=4'
@browser.goto(url)

@browser.text_field(:name => 'txtCategory').click
sleep(1)
@browser.span(:text => /Browse Categories/).click

finalCats = {}
Cats = {}
@browser.select_list(:name => 't0').options.each do |root|

next if root.text == "Animals & Pets"
next if root.text == "Arts & Entertainment"
next if root.text == "Automotive"
next if root.text == "Beauty & Fitness"
next if root.text == "Building & Construction"
next if root.text == "Business Services"
next if root.text == "Community & Government"
next if root.text == "Computers & Electronics"
next if root.text == "Education & Employment"
next if root.text == "Forestry & Agriculture"
next if root.text == "Health Care & Medical"
next if root.text == "Home & Garden"
next if root.text == "Industrial Supplies & Machinery"
next if root.text == "Legal & Financial"
next if root.text == "Media & Communications"

  
  puts(root.text)
	root.click
	sleep(2)
  next if @browser.text.include? "You have an error in your SQL syntax;"
  sub1hash = {}
  sub1array = []
	@browser.div(:id => 'd0').select(:class => 'grey_12pt').options.each do |sub1|
    next if @browser.text.include? "You have an error in your SQL syntax;"
		@browser.div(:id => 'd0').select(:class => 'grey_12pt').clear
    puts(" > " +sub1.text)
		subname = "t"+sub1.value
    
    sub1.click
        
    Watir::Wait.until{ @browser.img(:src => 'images/category_submit.jpg').exists? or @browser.select_list(:name => "#{subname}").exists? } 
    next if @browser.text.include? "You have an error in your SQL syntax;"
    if @browser.select_list(:name => "#{subname}").exists?    
      sub2hash = []
      @browser.select_list(:name => "#{subname}").options.each do |sub2|
        next if @browser.text.include? "You have an error in your SQL syntax;"
          puts(" > > "+sub2.text)
          sub2hash.push(sub2.text)
      end      
		end
    
   sub1hash[sub1.text] = sub2hash
   #sub1array.push(sub1hash)
    
    
	end
  
  Cats[root.text] = sub1hash
  

@browser.select_list(:name => 't0').clear

end
finalCats = Cats

file = File.open("categories.json", "w")
file.write(finalCats.to_json)
file.close unless file == nil

