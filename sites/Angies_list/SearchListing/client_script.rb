def search_business(data)
	@browser.wait_until {@browser.div(:class , 'RegistrationLightbox').exist? }
	result_count = @browser.table(:class, 'wide100percent').rows.length

        #Search for matching result
	for n in 1...result_count
		result = @browser.table(:class, 'wide100percent')[n].text
		if result.include?(data[ 'business' ])
			@browser.table(:class, 'wide100percent')[n].image(:alt,'Select').click
			$matching_result = true
			break
		end
	end
	return $matching_result
end

 @browser.goto( 'https://business.angieslist.com/Registration/Registration.aspx' )
  @browser.text_field(:id => /CompanyName/).set data[ 'business' ]
  @browser.text_field(:id => /CompanyZip/).set data[ 'zip' ]
  @browser.image(:alt,'Search').click
  
  Watir::Wait.until { @browser.text.include? "Select a Company" }
  #Check if business already listed
  @error_msg = @browser.span(:class,'errortext')
  @no_match_text = 'No companies were found. Try entering partial information in the search fields.'

if @browser.text.include?(@no_match_text)
  businessFound = [:unlisted]
elsif search_business(data)
    businessFound = [:listed,:unclaimed]
else
businessFound = [:unlisted]
end

[true, businessFound]
