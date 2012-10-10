
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

  #@browser.div( :class, 'LiveUI_Area_Business_Hours' ).div( :class, 'LiveUI_Field_Flag' ).click
  #Watir::Wait::until do @browser.div( :text , 'Set Hours' ).visible? end
  #@browser.div( :text , 'Set Hours' ).click

  #if business['open_24_hours'] == true
  #  @browser.div( :id, 'Popup_1||Hours_of Operation||Open24Hours||Open24HoursField' ).click
  #else
  #  @browser.div( :class, 'LiveUI_Area_HoursEntry' ).text_field( :index, 0 ).set business[ 'hours_monday_from' ]
  #  @browser.div( :class, 'LiveUI_Area_HoursEntry' ).text_field( :index, 1 ).set business[ 'hours_monday_to' ]
  #end

  # @browser.div( :text, 'Ok' ).click

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

def main( business )

  #@browser.goto( 'https://signup.live.com/' )
  #sign_up( business )

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

@browser = Watir::Browser.new

main( data )
