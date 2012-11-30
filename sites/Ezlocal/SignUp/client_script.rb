begin
@browser.goto("https://secure.ezlocal.com/newbusiness/default.aspx")
#@browser.text_field(:id =>"tPhone1").set data['phone_area_code']
#@browser.text_field(:id => "tPhone2").set data['phone_prefix']
#@browser.text_field(:id => "tPhone3").set data['phone_number']
#@browser.a(:id => "bSubmit").click
@browser.text_field(:id => "tBusinessName").set data['name']
@browser.text_field(:id => "tPhone1").set data['phone_area_code']
@browser.text_field(:id => "tPhone2").set data['phone_prefix']
@browser.text_field(:id => "tPhone3").set data['phone_number']
@browser.text_field(:id => "tBusinessAddress").set data['address']
@browser.text_field(:id => "tBusinessAddress2").set data['address2']
@browser.text_field(:id => "tFax1").set data['fax_area_code']
@browser.text_field(:id => "tFax2").set data['fax_prefix']
@browser.text_field(:id => "tFax3").set data['fax_number']
@browser.text_field(:id =>"tBusinessCity").set data['city']
@browser.select_list(:id => "dBusinessState").select data['state_long']
@browser.text_field(:id => "tBusinessZip").set data['zip']
@browser.text_field(:id => "tFirstName").set data['first_name']
@browser.text_field(:id => "tLastName").set data['last_name']
@browser.text_field(:id => "tContactPhone1").set data['phone_area_code']
@browser.text_field(:id => "tContactPhone2").set data['phone_prefix']
@browser.text_field(:id, "tContactPhone3").set data['phone_number']
@browser.text_field(:id => "tEmail").set data['email']
@browser.select_list(:id => "dCategory").select data['ezlocal_category1']
@browser.button(:id => "bSubmit").click
@browser.a(:text => "None of these, just a free basic listing.").click
@browser.text_field(:id => "tDescription").set data['description']
@browser.select_list(:id => "dCategory2").select data['ezlocal_category2']
@browser.select_list(:id => "dCategory3").select data['ezlocal_category3']
@browser.text_field(:id => "tWebsite").set data['website']
@browser.button(:id => "btnContinue").click
@browser.checkbox(:id => "chkTerms").click
@browser.button(:id => "bFinish").click
@browser.a(:text => "finish and submit your profile.").click
if @browser.text.include? 'Welcome to EZlocal - Your profile is now active!'
puts( 'Account signup and business registration successful!' )
true
end

rescue Exception => e
  puts("Exception Caught in Business Listing")
  puts(e)
end
