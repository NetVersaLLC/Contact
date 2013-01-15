def service_group(group)
	group = 'ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_AddCompanyControl_ProviderTypeCheckboxList_0' if group == ''
	if group == 'Consumer Services'
		group = 'ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_AddCompanyControl_ProviderTypeCheckboxList_0'
	elsif group == 'Classic Car Services'
		group = 'ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_AddCompanyControl_ProviderTypeCheckboxList_1'
	elsif group == 'Health Related Services'
		group = 'ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_AddCompanyControl_ProviderTypeCheckboxList_2'
	end
	return group
end

# Claim Business
def claim_business(data)
	@browser.text_field(:id,/SPAFirstName/).set data[ 'first_name' ]
	@browser.text_field(:id,/SPALastName/).set data[ 'last_name' ]
	@browser.text_field(:id,/SPAEmail/).set data[ 'email' ]
	@browser.text_field(:id,/SPAPassword/).set data[ 'password' ]
	@browser.text_field(:id,/SPAPasswordConfirm/).set data[ 'password' ]
#	@browser.(:id,/ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_SetupAccountAccessControl_AgreementCheckbox/).set
#	@browser.span( :class, 'checkbox').click
	@browser.execute_script( "$('input[id=ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_SetupAccountAccessControl_AgreementCheckbox]').attr('checked', true);" )
	sleep(3)
	@browser.image(:alt,'Submit').click
	
	#Validation error
	@validation_error = @browser.div(:id,/ValidationSummary/)
	if @validation_error.exist?
		throw("Please correct these value:#{@validation_error.text}")
	elsif @browser.html.include?('Thank you for registering!')
		puts "Business listing claim successful"
		true
	end
end	

#Search for specific business from matching results
def search_business(data)
	@browser.wait_until {@browser.div(:class , 'RegistrationLightbox').exist? }
	result_count = @browser.table(:class, 'wide100percent').rows.length

        #Search for matching result
	for n in 1...result_count
		result = @browser.table(:class, 'wide100percent')[n].text
		if result.include?(data[ 'company_name' ])
			@browser.table(:class, 'wide100percent')[n].image(:alt,'Select').click
			$matching_result = true
			break
		end
	end
	return $matching_result
end

# Main Script start from here
# Launch url
#@url = 'https://business.angieslist.com/'
#  @browser.goto(@url)
  
  #sign out
 # @sign_out = @browser.link(:text, 'Sign Out')
  #@sign_out.click if @sign_out.exist?
  
  #Fill form on Step -I
  @browser.goto( 'https://business.angieslist.com/Registration/Registration.aspx' )
  @browser.text_field(:id => /CompanyName/).set data[ 'company_name' ]
  @browser.text_field(:id => /CompanyZip/).set data[ 'zip' ]
  @browser.image(:alt,'Search').click
  sleep(5)
  
  #Check if business already listed
  @error_msg = @browser.span(:class,'errortext')
  @no_match_text = 'No companies were found. Try entering partial information in the search fields.'
  
  if not @browser.span( :text => /#{data['company_name']}/i).exists?
	  @browser.image(:alt,'Add Company').click
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyName/).when_present.set data['company_name']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyAddress/).set data['address']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyCity/).set data['city']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyState/).set data['state']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyPostalCode/).set data['zip']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyPhone/).set data['phone']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyEmail/).set data['email']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyContactFirstName/).set data['first_name']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').text_field(:id,/CompanyContactLastName/).set data['last_name']
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').checkbox(:id,service_group("#{data['service_group']}")).set
	  sleep(3)
	  @browser.select_list(:id,/AddCompanyControl_CategorySelections_leftlstbox/).when_present.select data['category']
	  @browser.button(:value,'>').click
	  sleep(3)
	  @browser.div(:class,'lightboxcontentbackground paddedmargin10').image(:alt,'Continue').click
	   
	   #check for validation error
	  @validation_error = @browser.div(:id,/ValidationSummary/)
	  if @validation_error.exist?
		  throw("Please correct these value:#{@validation_error.text}")
	  end
	  @browser.text_field(:id,/SPAFirstName/).set data[ 'first_name' ]
	  @browser.text_field(:id,/SPALastName/).set data[ 'last_name' ]
	  @browser.text_field(:id,/SPAEmail/).set data[ 'email' ]
	  @browser.text_field(:id,/SPAPassword/).set data[ 'password' ]
	  @browser.text_field(:id,/SPAPasswordConfirm/).set data[ 'password' ]
	  @browser.checkbox(:id,/AgreementCheckbox/).focus

	  @browser.execute_script( "$('input[id=ctl00_ContentPlaceHolderMainContent_SimpleRegistrationWizard_SetupAccountAccessControl_AgreementCheckbox]').attr('checked', true);" )
#	  @browser.checkbox(:id,/AgreementCheckbox/).click
	  @browser.image(:alt,'Submit').click 
	  
	  #check for validation error
	  if @validation_error.exist?
		  throw("Please correct these value:#{@validation_error.text}")
	  elsif @browser.html.include?('Thank you for registering!')
		  puts "Initial registration is successful"
	  end
	  
	  # Update Profile
	  @browser.image(:alt,'Access your profile').click
	    if @browser.div(:class,'Profile-Edit-Alert').exist?
		@browser.button(:alt,'Continue').when_present.click
		@browser.text_field(:id,/ServiceAreaDescription/).set data[ 'description' ]
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_ServiceAreaEditControl_ServiceAreaDescriptionSaveButton').when_present.click
		@browser.link(:text,'Set all').when_present.click
		sleep(2)
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_RegionZoneEditControl_RegionSaveButton').when_present.click
		@browser.wait_until {@browser.select_list(:id, /AddCategory_CategoryToSelect/).exist? }
		sleep(2)
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_ServiceOfferedEditControl_AddCategory_AddCategorySaveButton').when_present.click
		@browser.text_field(:id,/BusinessDescription/).when_present.set data[ 'business_description' ]
		@browser.text_field(:id,/ServicesOffered/).set data[ 'service_offered' ]
		@browser.text_field(:id,/ServicesNotOffered/).set data[ 'service_not_offered' ]
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_ServiceOfferedEdit_BusinessService_EditBusinessSaveButton').when_present.click
		Watir::Wait.until { @browser.text.include? 'Payment Details' }
		@browser.radio(:value => "#{data['check']}", :id => /ctl01_PaymentTypeRadioButton/).when_present.set
		@browser.radio(:value => "#{data['visa']}", :id => /ctl02_PaymentTypeRadioButton/).set
		@browser.radio(:value => "#{data['mastercard']}", :id => /ctl03_PaymentTypeRadioButton/).set
		@browser.radio(:value => "#{data['american_express']}", :id => /ctl04_PaymentTypeRadioButton/).set
		@browser.radio(:value => "#{data['discover']}", :id => /ctl05_PaymentTypeRadioButton/).set
		@browser.radio(:value => "#{data['paypal']}", :id => /ctl06_PaymentTypeRadioButton/).set
		@browser.radio(:value => "#{data['financing_available']}", :id => /ctl07_PaymentTypeRadioButton/).set
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_PaymentDetailEditControl_SaveButton').when_present.click
		Watir::Wait.until { @browser.text.include? 'Business Details' }
		sleep(3)
		@browser.select_list(:id, /ctl00_SetOpenDropDownList/).when_present.select clean_time( data['weekdays_opening_hours'] )
		sleep(3)
		@browser.select_list(:id, /ctl00_SetCloseDropDownList/).when_present.select clean_time( data['weekdays_closing_hours'] )
		sleep(3)
		@browser.select_list(:id, /ctl01_SetOpenDropDownList/).when_present.select clean_time( data['weekend_opening_hours'] )
		sleep(3)
		@browser.select_list(:id, /ctl01_SetCloseDropDownList/).when_present.select clean_time( data['weekend_closing_hours'] )
		@browser.button(:id,'ctl00_ContentPlaceHolderMainContent_CocoFunnelSection_CoCoFunnelWizard_BusinessDetailEditControl_BusinessDetailSaveButton').when_present.click
		Watir::Wait.until { @browser.text.include? 'License Details' }
		@browser.select_list(:id, /LicenseSignature/).when_present.select data['license_signature'] 
		@browser.button(:title,'Save').when_present.click
		Watir::Wait.until { @browser.text.include? 'Thank you! 100% complete profile helps members find and contact you.' }
		@thankyou_block = @browser.div(:id,/ThankYouKenticoBlock/)
		if @browser.wait_until {@thankyou_block.exist?}
			puts "Profile updated Successfully with message:#{@thankyou_block.text}"
		else
			throw("Profile didn't updated successfully")
		end
		@browser.button(:src,/close_btn/).click
		RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data['email'], 'account[password]' => data['password'], 'model' => 'AngiesList'
		true
	  end
	  
  elsif  search_business(data)
	  puts "Business already Listed"
	  claim_business(data)
	  RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data['email'], 'account[password]' => data['password'], 'model' => 'AngiesList'
  end
   

