url = 'http://webapp.localeze.com/directory/get-started.aspx'
#@browser.maximize()
@browser.goto(url)
#@browser.speed = :slow

begin
@browser.goto(url)
#@browser.link(:href => /get-started/).click
#@browser.close
#@browser = Watir::Browser.attach(:url, url)
#@browser.maximize()
@browser.link(:href => /how-to-getacct/).click
@browser.link(:href => /search/).click
@browser.div(:id,'search-directory').ul(:id,'search-tabs').link(:text,/Business Name/).click
@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_SearchControl_txtBusinessName').set data[ 'business' ] 
@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_SearchControl_txtPostalCode').set data[ 'zip' ] 
@browser.button(:id,'ctl00_ContentPlaceHolderMain_SearchControl_SearchByNameButton').click

#@browser.wait_until { @browser.div(:class => 'well', :index => 2).exist?}

# Search for existing listing
if @browser.div(:id => 'search-directory-results').exists?
	puts "Business is Already Listed"
else
#Step 1
	@browser.link(:text,'Add a new listing to our directory.').click
	@browser.wait_until { @browser.div(:class,'content shadowed').exist?}
	@browser.div(:class,'content shadowed').button(:id,'ctl00_ContentPlaceHolderMain_signinsupPopUp_Btn_SignUp').click
	@browser.div(:class,'content shadowed').radio(:value,"#{data['associated_as']}").set
	@browser.div(:class,'content shadowed').button(:id,'ctl00_ContentPlaceHolderMain_signinsupPopUp_Next').click
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtBusinessName').set data[ 'business' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtDepartment').set data[ 'department' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtListingAddress').set data[ 'address' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtListingCity').set data[ 'city' ] 
	@browser.select_list(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_ddlState').select data[ 'state' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtListingZip').set data[ 'zip' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_txtPhone').set data[ 'phone' ] 
	@browser.link(:text,'View List').click

	@browser.text_field(:name,'category').set data[ 'category' ] 

	@browser.link(:text,/#{data[ 'category' ].upcase}/).when_present.click
	@browser.link(:id,'btn-category-pop').click
	@browser.button(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_nextButton').click

# Check for error message if any
	@error_header = @browser.div(:id,'ctl00_ContentPlaceHolderMain_BusinessInformation_ValidationSummary1')
	if @error_header.exist? && @error_header.text.include?('Please correct the marked field')
		throw("Throwing Error:#{@error_header.text}")
	end
end

#Step -2
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtFirstName').set data[ 'first_name' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtLastName').set data[ 'last_name' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtAddress').set data[ 'address' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtCity').set data[ 'city' ] 
	@browser.select_list(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_ddlStates').select data[ 'state' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtZipCode').set data[ 'zip' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtPhoneNumber').set data[ 'phone' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtEmail').set data[ 'email' ] 
	@browser.text_field(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_txtEmailConfirm').set data[ 'email' ] 
	@browser.button(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_nextBujtton').click
# Verify step -2
	@error_header_contact = @browser.div(:id,'ctl00_ContentPlaceHolderMain_UserContactInfo_ValidationSummary')
	if @error_header_contact.exist? && @error_header_contact.text.include?('Please correct the marked field')
		throw("Throwing Error:#{@error_header_contact.text}")
	end

if @chained
  @job.start("Localeze/VerifyPhone")
end

rescue Exception => e
  puts("Exception Caught in Business Listing")
  puts(e)
end