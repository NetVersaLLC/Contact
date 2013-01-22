require 'nokogiri'
require 'open-uri'
require 'rest_client'
require 'json'
require 'watir'

@browser = Watir::Browser.new
@browser.goto( 'http://www.yellowassistance.com/frmBusinessUpdate.aspx' )

seed = (1000..2000).to_a.sample
@browser.text_field( :name => 'txtPhoneSearch').set '913-456-'+seed.to_s
@browser.button( :id => 'btnSearch').click
@browser.text_field( :id => 'txtName').when_present.set "John Smith"
@browser.text_field( :id => 'txtTitle').set "Owner"
@browser.text_field( :id => 'txtEmail').set "bluetest"+seed.to_s+"@gmail.com"
@browser.text_field( :id => 'txtCEmail').set "bluetest"+seed.to_s+"@gmail.com"
@browser.text_field( :id => 'txtPhone').set '913-456-'+seed.to_s

@browser.text_field( :id => 'txtBusName').set "TestBiz"+seed.to_s
@browser.text_field( :id => 'txtAddress').set seed.to_s+" Applewood st"
@browser.text_field( :id => 'txtCity').set "Leawood"
@browser.select_list( :id => 'ddlState').select "KS"
@browser.text_field( :id => 'txtZip').set "66224"

@browser.text_field( :id => 'txtBusPhone').set '913-456-'+seed.to_s

@browser.button( :id => 'btnContinue1').click

@browser.link( :id => 'lbtnSearchAll').when_present.click
sleep(15)
selectList = @browser.select_list(:id => "lboxAvailableCats")
selectContent = selectList.options.map(&:text)


file = File.open("categories.txt", "w")
selectContent.each do |option|
	file.write(option + "\n")
	puts(option)
end
file.close unless file == nil











