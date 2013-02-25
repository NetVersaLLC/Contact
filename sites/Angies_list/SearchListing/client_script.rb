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

 @browser.goto( 'https://business.angieslist.com/Registration/Registration.aspx' )
  @browser.text_field(:id => /CompanyName/).set data[ 'company_name' ]
  @browser.text_field(:id => /CompanyZip/).set data[ 'zip' ]
  @browser.image(:alt,'Search').click
  sleep(5)
  
  #Check if business already listed
  @error_msg = @browser.span(:class,'errortext')
  @no_match_text = 'No companies were found. Try entering partial information in the search fields.'

if @browser.text.include?(@no_match_text)
  puts("No business")
  businessFound = [:unlisted]
elsif search_business(data)
    businessFound = [:listed,:unclaimed]
else
businessFound = [:unlisted]
  puts("second unlisted")
end

puts(businessFound)
return true, businessFound
