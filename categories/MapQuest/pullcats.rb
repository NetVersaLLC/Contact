require 'watir-webdriver'

file = File.open("categories.txt","w")

@browser = Watir::Browser.new
@browser.goto("www.google.com")
# Manually login and navigate to categories page
category = gets.chomp # Type a random category to search
@browser.text_field(:class => "jsonform-category").set category
stall = gets # Press enter once the selectlist is visible
@browser.div(:class => "ac-renderer").divs(:class, "ac-row").each { |option|
	puts "Writing: #{option.text}"
	file.write(option.text + "\n")
}