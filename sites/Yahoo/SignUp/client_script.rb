# See test_pages.rb for the data{} hash

def search_for_business( business )

  puts 'Search for the ' + business[ 'business_name' ] + ' business at ' + business[ 'zip' ] + ' zip location'
  #@browser = Watir::Browser.start( 'http://local.yahoo.com/browse_state.php' )
  #@browser.speed = :slow
  #@browser.maximize()
  @browser.text_field( :id => 'yls-p' ).set business[ 'business_name' ]
  @browser.text_field( :id => 'yls-csz' ).set business[ 'zip' ]
  @browser.button( :value => 'Search' ).click

end

def wait_for_results

  # Maybe only serach by class, since it gets 1st link that is most relevant, but
  # aware of ads displayed above search results with the same text
  # @business_name = data[ 'business_name' ]
  @business_name_link = @browser.link( :class => 'yschttl spt' ) #, :text => @business_name
  @not_found_text_present = @browser.text.include? "Try the suggestions below"
  Watir::Wait::until do
    @business_name_link.exists? or @not_found_text_present
  end

end

def edit_as_business_owner

  puts 'Business is found - Edit as business owner'
  @business_name_link.click

  # Warning: there were problems with this link, maybe because it has "href??"
  def edit_business_link; @browser.a( :text => 'Edit business details' ) end # :class => 'yl-edit-biz',
  Watir::Wait::until do edit_business_link.exists? end
  if edit_business_link.exists?
    edit_business_link.click
  else
    raise StandardError.new( 'The business is already claimed' )
  end

  def business_owner_link; @browser.link( :text => 'Edit as a business owner?' ) end
  Watir::Wait::until do business_owner_link.exists? end
  business_owner_link.click

end

def goto_sign_up

  puts 'Business is not found - Sign up for new account'
  @browser.goto( 'http://listings.local.yahoo.com/' )
  @browser.link( :text => 'Sign Up' ).click

end

def sign_up_personal( business )

  puts 'Sign up for new Yahoo account'
  @browser.link(:id => 'signUpBtn').click

  @browser.text_field( :id => 'firstname' ).set business[ 'first_name' ]
  @browser.text_field( :id => 'secondname' ).set business[ 'last_name' ]
  @browser.select_list( :id => 'gender' ).select business[ 'gender' ]
  @browser.select_list( :id => 'mm' ).select business[ 'month' ]
  @browser.text_field( :id => 'dd' ).set business[ 'day' ]
  @browser.text_field( :id => 'yyyy' ).set business[ 'year' ]
  @browser.select_list( :id => 'country' ).select business[ 'country' ]
  @browser.select_list( :id => 'language' ).select business[ 'language' ]
  @browser.text_field( :id => 'postalcode' ).set business[ 'zip' ]

  # .. select email
  @browser.text_field( :id => 'yahooid' ).clear # shows suggestions list; [click, flash]
  Watir::Wait::until do @browser.h5( :text => 'Here are some suggestions...' ).exists? end
  @browser.div( :id => 'yidsuggestion' ).link.click

  # .. remember the selected email to click in account confirmation email later
  Watir::Wait::until do @browser.span( :id => 'choosenyid' ).exists? end
  business[ 'business_email' ] = @browser.span( :id => 'choosenyid' ).text

  # or browser.ol( :id => 'yidSug' ).li( :index => 0 ).click;
  # browser.find_elements_by_xpath("div[@id='yidsuggestion'/li[0]").click
  @browser.text_field( :id => 'password' ).set business[ 'password' ]
  @browser.text_field( :id => 'passwordconfirm' ).set business[ 'password' ]

  # .. skip alternate email
  @browser.select_list( :id => 'secquestion' ).option( :index => 1 ).select
  @browser.text_field( :id => 'secquestionanswer' ).set business[ 'secret_answer_1' ]
  @browser.select_list( :id => 'secquestion2' ).option( :index => 1 ).select
  @browser.text_field( :id => 'secquestionanswer2' ).set business[ 'secret_answer_2' ]

  file = Tempfile.new('image.png')
  @browser.image(:id, 'captcha').save file.path
  text = CAPTCHA.solve file.path, :yahoo
  @browser.text_field( :id => 'captcha_text' ).set text

  # @browser.text_field( :id => 'captchaV5Answer' ).set 'Captcha'
  sleep 12
  @browser.button( :id => 'IAgreeBtn' ).click

end

def continue_to_yahoo_local

  puts 'Continue to Yahoo Local'
  if not @browser.title == 'Yahoo! Registration Confirmation' #and @browser.text.include? 'Congratulations'
    raise StandardError.new( 'Not on Registration Confirmation page' )
  end

  # .. waits long here
  def homepage_checkbox; @browser.checkbox( :id => 'setHomepage' ) end
  if homepage_checkbox.exists? then homepage_checkbox.clear end

  @browser.button( :id => 'ContinueBtn' ).click

end

def existing_business

  !@browser.text.include? 'Submit Your Business Information' and
     @browser.text.include? 'Optional Business Information'

end

def provide_business_info( business, is_existing )

  #@browser = Watir::IE.attach( :title => 'Test New Window' )
  
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

  file = Tempfile.new('image.png')
  @browser.image( :id => 'prcaptcha' ).save file.path

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

  search_for_business( business )
  wait_for_results

  if @business_name_link.exists?
    edit_as_business_owner
  elsif @not_found_text_present
    goto_sign_up
  else
    ContactJob.failure( 'Invalid condition after business search!' )
  end

  sign_up_personal( business )
  continue_to_yahoo_local

  provide_business_info( business, existing_business )
  preview_and_submit
  
  ContactJob.start( 'Yahoo/Verify' )

end

if main( data ) == true
  true
else
  false
end
