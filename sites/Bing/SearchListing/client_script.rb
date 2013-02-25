def listing_already_exists2

  #@claim_business_link = @browser.div( :text , 'Claim' )
  #@not_found_text = @browser.div( :class, 'LiveUI_Area_NoMatches' )
  def claim_business_link; @browser.div( :text, 'Claim' ) end
  def not_found_text; @browser.text.include? 'NO MATCHES FOUND' end

  # if claim check is first and no results found it waits for 30 seconds and fails
  Watir::Wait.until {not_found_text or claim_business_link.exists?}

  if not_found_text
    puts 'No results found'
    return false
  elsif claim_business_link.exists?
    puts 'Found business named ' + @browser.div( :class, 'LiveUI_Area_Business_Details' ).text
    return true
  else
    raise StandardError.new( 'Invalid condition after business search!' )
  end
  
end


def search_for_business2( business )

  @browser.goto( 'http://www.bing.com/businessportal/' )
  puts 'Search for the ' + business[ 'name' ] + ' business at ' + business[ 'city' ] + ' city'
  @browser.link( :text , 'Get Started Now!' ).click

  #sleep 4 # seems that div's are not loaded quickly simetimes
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).when_present.click
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).flash
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).focus
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'name' ]
  @browser.div( :class , 'LiveUI_Area_Find___City' ).text_field( :class, 'LiveUI_Field_Input' ).click
  @browser.div( :class , 'LiveUI_Area_Find___City' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'city' ]
  @browser.div( :class , 'LiveUI_Area_Find___State' ).text_field( :class, 'LiveUI_Field_Input' ).click
  @browser.div( :class , 'LiveUI_Area_Find___State' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'state_short' ]
  @browser.div( :class , 'LiveUI_Area_Search_Button LiveUI_Short_Button_Medium' ).click
  #sleep 4
  
end

businessFound = []

search_for_business2( data )
result = listing_already_exists2()

if result == true  
  businessFound = [:listed,:unclaimed]  
else
  businessFound = [:unlisted]
end
[true, businessFound]