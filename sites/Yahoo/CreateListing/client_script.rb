def goto_sign_up
  puts 'Business is not found - Sign up for new account'
  @browser.goto( 'http://listings.local.yahoo.com/' )
  @browser.link( :text => 'Sign Up' ).click
end

def provide_business_info( business, is_existing )
  # Provide Your Business Information
  @browser.text_field( :id => 'cfirstname' ).set business[ 'first_name' ]
  @browser.text_field( :id => 'clastname' ).set business[ 'last_name' ]
  @browser.text_field( :id => 'email' ).set business[ 'email' ]
  @browser.text_field( :id => 'phone' ).set business[ 'phone' ]

  # Business Information
  @browser.text_field( :id => 'coEmail' ).set business[ 'business_email' ]
  if is_existing then
    # .. skip business name, address, phone and website as they are pre populated here
  else

    # .. fill all the info because its blank
    @browser.text_field( :id => 'bizname' ).set business[ 'business_name' ]
    @browser.text_field( :id => 'addr' ).set business[ 'business_address' ]
    @browser.text_field( :id => 'city' ).set business[ 'business_city' ]
    @browser.select_list( :id => 'state' ).select business[ 'business_state' ]
    @browser.text_field( :id => 'zip' ).set business[ 'business_zip' ]
    @browser.text_field( :id => 'addphone' ).set business[ 'business_phone' ]
    # TODO: add website @browser.text_field( :id => '?' ).set business[ 'business_website' ]

    @browser.text_field( :id => 'acseccat1' ).set business[ 'business_categoty' ]
    sleep 5
    @browser.p( :class => 'autocomplete-row-margins' ).click
    #@browser.div( :id => 'add-category-row-1' ).click # add the category to test it

    @browser.button( :id => 'submitbtn' ).click
    Watir::Wait::until do @browser.text.include? 'Optional Business Information' end

  end

  # Primary Category and details
  # @browser.text_field( :id => 'fax' ).set business[ 'fax_number' ]
  if @browser.h3( :id => 'categoryextra-collapsed' ).exists?
    @browser.h3( :id => 'categoryextra-collapsed' ).click
  end
  
  # Consider setting these urls
  if @browser.text_field( :id => 'ticketsurl' ).exists?
    @browser.text_field( :id => 'ticketsurl' ).clear
  end
  if @browser.text_field( :id => 'guestlisturl' ).exists?
    @browser.text_field( :id => 'guestlisturl' ).clear
  end

  # Optional Business Information
  @browser.h3( :id => 'otheroperationdetails-collapsed' ).click
  @browser.text_field( :id => 'established' ).set business[ 'year_established' ]
  business[ 'payment_methods' ].each{ | method |
    @browser.select_list( :id => 'payment' ).select method
  }
  @browser.text_field( :id => 'langserved' ).set business[ 'languages_served' ]
end

def preview_and_submit
  puts 'Preview and close'
  @browser.button( :id => 'preview-bottom-btn' ).click
  sleep 10
  Watir::Wait::until do @browser.button( :id => 'prcloser' ).exists? end
  @browser.button( :id => 'prcloser' ).click

  # require "deathbycaptcha"
  puts 'Submit the business'
  sleep 10 # TODO: wait instead
  @browser.checkbox( :id => 'atc' ).click
  @browser.button( :id => 'submitbtn' ).click

  if @browser.text.include? 'Congratulations' # 'Pending Verification', 'Get a Verification Code'
    puts 'Congratulations, Yahoo! Local Listing Id: ' + @browser.label( :id => 'lc-listIdLabel' ).text
  else
    raise StandardError.new( "Problem to submit the business info!" )
  end
end

def main( business )
  sign_in(business)

  goto_sign_up
  provide_business_info( business, existing_business )
  preview_and_submit
end

@browser = Watir::Browser.new

main(data)

true
