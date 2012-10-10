def listing_already_exists
  @claim_business_link = @browser.div( :text , 'Claim' )
  @not_found_text = @browser.div( :class, 'LiveUI_Area_NoMatches' )

  Watir::Wait::until do
    @claim_business_link.exists? or @not_found_text.exists?
  end

  if @claim_business_link.exists?
    puts 'Found business named ' + @browser.div( :class, 'LiveUI_Area_Business_Details' ).text
    return true
  else @not_found_text.exists?
    puts 'No results found'
    return false
  end
  return nil
end

sign_in( business )
search_for_business( business )
result = listing_already_exists()
if result == true
  ContactJob.start("Bing/ClaimListing")
elsif result == false
  ContactJob.start("Bing/CreateListing")
else
  raise StandardError.new( 'Invalid condition after business search!' )
end

true
