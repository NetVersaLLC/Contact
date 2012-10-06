require "rubygems"
require "watir"
require 'tmpdir'
require "../../citation/lib/captcha.rb"

CAPTCHA_TYPE = :test #:bing

def search_for_business( business )

  puts 'Search for the ' + business[ 'name' ] + ' business at ' + business[ 'city' ] + ' city'
  @browser.link( :text , 'Get Started Now!' ).click
  sleep 2 # seems that div's are not loaded quickly simetimes
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'name' ]
  @browser.div( :class , 'LiveUI_Area_Find___City' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'city' ]
  @browser.div( :class , 'LiveUI_Area_Find___State' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'state_short' ]

  @browser.div( :class , 'LiveUI_Area_Search_Button LiveUI_Short_Button_Medium' ).click

end

def wait_for_results

  @claim_business_link = @browser.div( :text , 'Claim' )
  @not_found_text = @browser.div( :class, 'LiveUI_Area_NoMatches' )
  
  Watir::Wait::until do
    @claim_business_link.exists? or @not_found_text.exists?
  end

  if @claim_business_link.exists?
    puts 'Found business named ' + @browser.div( :class, 'LiveUI_Area_Business_Details' ).text
  else @not_found_text.exists?
    puts 'No results found'
  end

end

def solve_captcha

  puts 'Solve captcha'

  # TODO: test the real catpcha solving
  #sleep 12
  #file_path = Dir.tmpdir + '/bing_local_captcha.png'
  #if File.exist? file_path
  #  File.delete( file_path )
  #end
  #
  #@browser.image( :src, /HIPImage/ ).save( Dir.tmpdir )
  #captcha_text = CAPTCHA.solve( file_path, CAPTCHA_TYPE )
  #@browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).text_field().set captcha_text

  #File.delete( file_path )

  puts 'Enter the captcha text: '
  gets.strip

end

def add_new_listing( business )

  puts 'Add new listing'
  @browser.div( :text, 'Add new listing' ).click

  Watir::Wait::until do
    @browser.div( :class, 'Dialog_TitleContainer' ).exists?
  end

  # Note that business name, city, state and country are already populated.
  # Only USA as coutry is allowed at the time of this writing.
  @browser.div( :class , 'LiveUI_Area_Confirm___Address' ).text_field().set business[ 'address' ]
  @browser.div( :class , 'LiveUI_Area_Confirm___ZipCode' ).text_field().set business[ 'zip' ]
  @browser.div( :class , 'LiveUI_Area_Confirm___Phone' ).text_field().set business[ 'phone' ]

  captcha_text = solve_captcha()
  @browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).text_field().set captcha_text
  @browser.div( :text, 'Ok' ).click

end

def get_email_name( business )
  business[ 'name' ].downcase.delete( ' ' ).strip + business[ 'zip' ] + '_' + rand( 100 ).to_s()
  #'max'
end

def sign_up( business )

  @browser.text_field( :id, 'iFirstName' ).set business[ "first_name" ]
  @browser.text_field( :id, 'iLastName' ).set business[ "last_name" ]
  @browser.select_list( :id, 'iBirthMonth' ).select business[ 'birth_month' ]
  @browser.select_list( :id, 'iBirthDay' ).select business[ 'birth_day' ]
  @browser.select_list( :id, 'iBirthYear' ).select business[ 'birth_year' ]
  @browser.select_list( :id, 'iGender' ).select business[ 'gender' ]

  @browser.link( :id, 'iliveswitch' ).click
  sleep 2
  #email_name = get_email_name( business )
  #@browser.text_field( :id, 'imembernamelive' ).set email_name
  @browser.text_field( :name, 'iPwd' ).set business[ 'password' ]
  @browser.text_field( :name, 'iRetypePwd' ).set business[ 'password' ]

  @browser.link( :id, 'iqsaswitch' ).click
  sleep 2
  @browser.text_field( :id, 'iAltEmail' ).set business[ 'email' ]
  @browser.select_list( :id, 'iSQ' ).option( :index, 1 ).select
  @browser.text_field( :id, 'iSA' ).set business[ 'secret_answer' ]

  @browser.select_list( :id, 'iCountry' ).select business[ 'country' ]
  @browser.text_field( :id, 'iZipCode' ).set business[ 'zip' ]

  #captcha_text = solve_captcha()
  #@browser.text_field( :class, 'spHipNoClear hipInputText' ).set captcha_text
  @browser.checkbox( :id, 'iOptinEmail' ).clear
  #@browser.button( :title, 'I accept' ).click

  # Wait for processing and fix email if needed
  email_name = get_email_name( business )
  begin

    @browser.text_field( :id, 'imembernamelive' ).set email_name

    captcha_text = solve_captcha()
    @browser.text_field( :class, 'spHipNoClear hipInputText' ).set captcha_text

    @browser.button( :title, 'I accept' ).click

    Watir::Wait::until do
      @browser.link( :text, 'Continue to Hotmail' ).exists? or  @browser.p( :id, 'iMembernameLiveError' ).exists?
      #and @browser.p( :id, 'iMembernameLiveError' ).text.include? "@hotmail.com isn't available." )
    end

    email_name = email_name + '1'

  end until @browser.link( :text, 'Continue to Hotmail' ).exists?

  business[ 'hotmail' ] = email_name + '@hotmail.com'
  @browser.link( :text, 'Continue to Hotmail' ).click

end

def sign_in( business )

  @browser.text_field( :name, 'login' ).set 'hopak12312321@hotmail.com' # business[ 'hotmail' ]
  @browser.text_field( :name, 'passwd' ).set business[ 'password' ]
  # @browser.checkbox( :name, 'KMSI' ).set
  @browser.button( :name, 'SI' ).click

end

def enter_personal_contact_info( business )

  @browser.div( :class, 'LiveUI_Area_Phone_number' ).text_field().set business[ 'phone' ]
  @browser.div( :class, 'LiveUI_Area_Confirm_Email_address1' ).text_field().set business[ 'hotmail' ]

  @browser.div( :class, 'LiveUI_Area_Agreement_of_Terms_and_Conditions' ).div( :class, 'LiveUI_Field_Flag' ).div().click
  @browser.div( :class, 'LiveUI_Area_Bing_Portal_Announcement_Subscription' ).div( :class, 'LiveUI_Field_Flag' ).div().click
  @browser.div( :text, 'Accept' ).click

  # TODO: assert form disappeared

end

def enter_business_portal_details( business )

  Watir::Wait::until do
    @browser.div( :text, 'YOUR BUSINESS INFORMATION' ).exists?
  end

  # .. Select business category
  @browser.div( :class, 'LiveUI_Area_Category' ).text_field().focus
  # Can't find the way to click on a first search result, so click on 1st category without searching
  # @browser.div( :class, 'LiveUI_Area_Browse_and_Search' ).text_field().set business[ 'category' ]
  # @browser.send_keys :enter
  Watir::Wait::until do
    @browser.div( :class, /Hierarchy_Item/ ).exists?
  end
  @browser.div( :title, /Arts & Entertainment/ ).div( :class, 'Name' ).fire_event( 'onMouseDown' )

  @browser.div( :class, 'LiveUI_Area_Toll_free_number' ).text_field().set business[ 'toll_free_number' ]
  @browser.div( :class, 'LiveUI_Area_Fax_number' ).text_field().set business[ 'fax_number' ]
  @browser.div( :class, 'LiveUI_Area_Email_Address' ).text_field().set business[ 'email' ]
  @browser.div( :class, 'LiveUI_Area_URL' ).text_field().set business[ 'website' ]
  @browser.div( :class, 'LiveUI_Area_Facebook_URL' ).text_field().set business[ 'facebook' ]
  @browser.div( :class, 'LiveUI_Area_Twitter_URL' ).text_field().set business[ 'twitter' ]

  @browser.div( :text, 'Next' ).click
  @browser.div( :text, 'Next' ).click # it is not redirected from 1st click, so click twice

end

def enter_business_portal_more_details( business )

  Watir::Wait::until do
    @browser.div( :class, 'LiveUI_Area_More_Details_Title' ).exists?
  end

  @browser.div( :class, 'LiveUI_Area_Established_Date' ).text_field().set business[ 'year_established' ]
  @browser.div( :class, 'LiveUI_Area_Description' ).text_field().set business[ 'description' ]

  @browser.div( :class, 'LiveUI_Area_Languages_spoken' ).text_field().focus
  sleep 2
  Watir::Wait::until do @browser.div( :text, 'Select' ).exists? end
  #business[ 'languages' ].each{ | language |
    #@browser.div( :text, /#{language}/ ).fire_event( 'onMouseUp' )
  #}
  @browser.div( :class => 'LiveUI_Field_Flag_Option', :index => 8 ).fire_event( 'onMouseUp' )
  @browser.div( :text , 'Ok' ).click

  @browser.div( :class, 'LiveUI_Area_Forms_of_payment_accepted' ).text_field().focus
  sleep 2
  Watir::Wait::until do @browser.div( :class , 'LiveUI_Field_Flag_Option' ).visible? end
  #business[ 'payments' ].each{ | payment |
   # @browser.div( :text, payment ).click
  #}
  @browser.div( :class => 'LiveUI_Field_Flag_Option', :index => 1 ).fire_event( 'onMouseUp' )
  @browser.div( :text , 'Ok' ).click

  @browser.div( :class, 'LiveUI_Area_Business_Hours' ).div( :class, 'LiveUI_Field_Flag' ).click
  Watir::Wait::until do @browser.div( :text , 'Set Hours' ).visible? end
  @browser.div( :text , 'Set Hours' ).click
  @browser.div( :class, 'LiveUI_Area_HoursEntry' ).text_field( :index, 0 ).set business[ 'hours_monday_from' ]
  @browser.div( :class, 'LiveUI_Area_HoursEntry' ).text_field( :index, 1 ).set business[ 'hours_monday_to' ]
  @browser.div( :text, 'Ok' ).click

  @browser.div( :text, 'Next' ).click
  
end

def enter_business_portal_mobile()

  Watir::Wait::until do
    @browser.div( :text, 'MOBILE SITE' ).exists?
  end

  @browser.div( :class, 'LiveUI_Area_FreeMobileSite' ).div( :class, 'LiveUI_Field_Flag' ).click
  @browser.div( :class, 'LiveUI_Area_CreateQRCode' ).div( :class, 'LiveUI_Field_Flag' ).click

  @browser.div( :text, 'Next' ).click

end

def claim_it()

  @browser.div( :text , 'Claim' ).click

  captcha_text = solve_captcha()
  @browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).text_field().set captcha_text
  @browser.div( :text , 'Continue' ).click

  Watir::Wait::until do
    @browser.div( :text, 'Ok' ).exists? # or  :class, 'Dialog_TitleContainer'
  end
  @browser.div( :text, 'Ok' ).click

  # Redirected to Business Portal - Details Page, so enter all the info as with new listing

end


def main( business )

  #@browser.goto( 'https://signup.live.com/' )
  #sign_up( business )

  @browser.goto( 'https://login.live.com/' )
  sign_in( business )

  @browser.goto( 'http://www.bing.com/businessportal/' )
  search_for_business( business )
  wait_for_results

  if @claim_business_link.exists?
    claim_it()
  elsif @not_found_text.exists?
    add_new_listing( business )
    enter_personal_contact_info( business )
  else
    raise StandardError.new( 'Invalid condition after business search!' )
  end

  enter_business_portal_details( business )
  enter_business_portal_more_details( business )

  # Refactor to separate functions
  Watir::Wait::until do
    @browser.div( :class, 'LiveUI_Area_Profile_Title' ).exists?
  end
  @browser.div( :text, 'Next' ).click # skip profile tab

  enter_business_portal_mobile()
  
  Watir::Wait::until do
    @browser.div( :text, 'PHOTOS' ).exists?
  end
  @browser.div( :text, 'Next' ).click # skip photos tab

  Watir::Wait::until do
    @browser.div( :class, 'LiveUI_Area_Publish_Title' ).exists?
  end
  @browser.div( :text, 'Next' ).click # skip preview tab

  @browser.div( :text, 'Verify' ).click

end


@data = {}
@data[ 'name' ] = 'Geisha'
#@data[ 'name' ] = 'Hopak'
@data[ 'city' ] = 'Columbia'
@data[ 'state_short' ] = 'MO'
@data[ 'state_full' ] = 'Missouri'

@data[ 'address' ] = '212 main street'
@data[ 'zip' ] = '65201'
@data[ 'phone' ] = '(425) 555-5555' # (XXX) XXX-XXXX
@data[ 'country' ] = 'United States'
@data[ 'password' ] = 'Passw0rd'
@data[ 'secret_answer' ] = '123123'

@data[ 'first_name' ] = 'MyName'
@data[ 'last_name' ] = 'Lname'
@data[ 'birth_month' ] = 'January'
@data[ 'birth_day' ] = '1'
@data[ 'birth_year' ] = '1970'
@data[ 'gender' ] = 'Male'
@data[ 'email' ] = 'some213@null.com'
@data[ 'hotmail' ] = nil # singed emails: hopak12312321@hotmail.com, hopak65201_98@hotmail.com

@data[ 'category' ] = 'Movie'
@data[ 'toll_free_number' ] = '(425) 555 5555'
@data[ 'fax_number' ] = '(425) 555 5555'
@data[ 'website' ] = 'http://mybusiness.com'
@data[ 'facebook' ] = 'http://facebook.com/mybusiness'
@data[ 'twitter' ] = 'http://twitter.com/mybusiness'

@data[ 'year_established' ] = '1970'
@data[ 'description' ] = 'Abra Kadabra'
@data[ 'languages' ] = [ 'English', 'French', 'Thai' ]
@data[ 'payments' ] = [ 'Mastercard', 'Visa', 'ATM' ]
@data[ 'hours_monday_from' ] = '8:00'
@data[ 'hours_monday_to' ] = '8:00'


@browser = Watir::Browser.new
#@browser.speed = :slow
@browser.maximize()

main( @data )
