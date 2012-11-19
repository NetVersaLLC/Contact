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

end

sign_in( business )
search_for_business( business )
add_new_listing( business )
enter_personal_contact_info( business )

if @chained
  @job.start("Bing/Update")
end

true
