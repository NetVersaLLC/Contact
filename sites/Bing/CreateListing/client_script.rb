def add_new_listing( business )

  puts 'Add new listing'
  watir_must do @browser.div( :text, 'Add new listing' ).click end
  watir_must do @browser.div( :class, 'Dialog_TitleContainer' ).exists? end
  #sleep 4 # because fails to wait
  puts '=== Done -> Watir::Wait::until do @browser.div( Dialog_TitleContainer ).exists?'

  # Note that business name, city, state and country are already populated.
  # Only USA as coutry is allowed at the time of this writing.
  # TODO: try focusing on fields first if it thinks they are blank
  @browser.div( :class , 'LiveUI_Area_Confirm___Address' ).text_field().set business[ 'address' ]
  @browser.div( :class , 'LiveUI_Area_Confirm___ZipCode' ).text_field().set business[ 'zip' ]
  @browser.div( :class , 'LiveUI_Area_Confirm___Phone' ).text_field().set business[ 'phone' ]

  captcha_text = solve_captcha( :add_listing )
  @browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).text_field().set captcha_text
  @browser.div( :text, 'Ok' ).click

end

def enter_personal_contact_info( business )

  # TODO: handle the case that personal info may be entered already and 'YOUR BUSINESS INFORMATION' page opens
  watir_must do # wait div( :class, 'LiveUI_Area_AcceptForm' )
    @browser.text.include? 'CONTACT INFORMATION AND COMMUNICATION PREFERENCES'
  end

  @browser.div( :class, 'LiveUI_Area_Phone_number' ).text_field().set business[ 'phone' ]
  @browser.div( :class, 'LiveUI_Area_Confirm_Email_address1' ).text_field().set business[ 'hotmail' ]

  @browser.div( :class, 'LiveUI_Area_Agreement_of_Terms_and_Conditions' ).div( :class, 'LiveUI_Field_Flag' ).div().fire_event( 'onMouseDown' )
  @browser.div( :class, 'LiveUI_Area_Agreement_of_Terms_and_Conditions' ).div( :class, 'LiveUI_Field_Flag' ).div().fire_event( 'onMouseUp' )
  @browser.div( :class, 'LiveUI_Area_Bing_Portal_Announcement_Subscription' ).div( :class, 'LiveUI_Field_Flag' ).div().fire_event( 'onMouseDown' )
  @browser.div( :class, 'LiveUI_Area_Bing_Portal_Announcement_Subscription' ).div( :class, 'LiveUI_Field_Flag' ).div().fire_event( 'onMouseUp' )
  @browser.div( :class, 'LiveUI_Area_btnAccept LiveUI_Button_Medium' ).click #watir_must do

end

sign_in( data )
search_for_business( data )
add_new_listing( data )
enter_personal_contact_info( data )

if @chained
  self.start("Bing/Update")
end

true
