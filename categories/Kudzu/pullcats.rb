require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'

@browser = Watir::Browser.new

url = 'https://register.kudzu.com/packageSelect.do'
@browser.goto(url)
@browser.button( :name, 'basicButton' ).click

seedString 			= rand( 1000 ).to_s()

@browser.text_field( :id => 'userName' ).set "asdfasdfasdf"+seedString
@browser.text_field( :id => 'email' ).set "asdfasdfasdf"+seedString+"@"+seedString+".com"
@browser.text_field( :id => 'pass1' ).set "asdfasdewrwe"+seedString
@browser.text_field( :id => 'pass2' ).set "asdfasdewrwe"+seedString
@browser.select_list( :id, 'securityQuestion' ).select "City of Birth?"
@browser.text_field( :id => 'answer' ).set "asdfasdewrwe"+seedString
@browser.button( :name, 'nextButton' ).click

@browser.text_field( :name => 'firstName' ).set "dfasasdfarew"
@browser.text_field( :name => 'lastName' ).set "treterter"

@browser.text_field( :name => 'businessName' ).set "asdfasdfasfasdfdfas"

@browser.text_field( :name => 'busCity' ).set "Leawood"
@browser.select_list( :name, 'busState' ).select "KS"
@browser.text_field( :name => 'busZip1' ).set "66224"

@browser.text_field( :name => 'busNPA' ).set "654"
@browser.text_field( :name => 'busNXX' ).set "456"
@browser.text_field( :name => 'busPlusFour' ).set "9871"
@browser.button( :name, 'nextButton' ).click
sleep(5)
@browser.button( :name, 'nextButton' ).click
sleep(5)
PrimeCats = @browser.select_list( :name => 'industry').options.map(&:text)

subCats = Hash.new()

PrimeCats.each do |cat1|
puts(cat1)
    primeycat = cat1.gsub(" ->","")
		@browser.select_list( :name => 'industry' ).select /#{primeycat}/		
		sleep(1)
		temps = @browser.select_list( :name => 'category').options.map(&:text)
		subCats[primeycat] = temps
			temps.each do |t|
				puts(" > " + t.to_s)
			end
					
end

finalCats = subCats.to_json
fJson = File.open("categories.json","w")
fJson.write(finalCats)
fJson.close

