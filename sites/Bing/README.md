- The hardest issue on Bing Business Portal is that normal click() methods don't work on Details tab where you should choose category, language or payment types (on More Details tab). It was at last discovered that focus() and fire_event( 'onMouseDown' ) methods of Watir::Element class works with Category popup, but still not with Language and Payment Options.


- First function used to sign up, but refused due to 404 error from bing, not being able to redirect back to the business page after sign up. So decided to add/claim business in signed in state.
def sign_up_hotmail( business )

  puts 'Sign up for new Hotmail account'

  Watir::Wait::until do
    @browser.h1( :text, 'Claim your business on Bing' ).exists?
  end

  @browser.link( :id, 'idA_SignUp' ).click
  @browser.radio( :id, 'i0166' ).set
  @browser.button( :name, 'Continue' ).click

  @browser.select_list( :id, 'iRegion' ).select business[ 'country' ]

  # Choose an available email
  email_name = get_email_name( business )
  begin

    @browser.text_field( :id, 'iEmail' ).set email_name
    @browser.button( :id, 'iCheckAval' ).click

    available_answer = @browser.text.include? '@hotmail.com is available.'
    not_available_answer = @browser.text.include? '@hotmail.com is not available.'

    Watir::Wait::until do
      available_answer or not_available_answer
    end

    email_name = email_name + '1'

  end until available_answer

  #TODO: save resulting email

  @browser.text_field( :id, 'iPassword' ).set business[ 'password' ]
  @browser.text_field( :id, 'iConfPassword' ).set business[ 'password' ]

  @browser.select_list( :id, 'iSQ' ).option( :index, 1 ).select
  @browser.text_field( :id, 'iSA' ).set business[ 'secret_answer' ]

  @browser.text_field( :id, 'iFN' ).set business[ 'first_name' ]
  @browser.text_field( :id, 'iLN' ).set business[ 'last_name' ]
  @browser.radio( :id, $genders[ business[ 'gender' ] ] ).set
  @browser.select_list( :id, 'iMTH' ).select business[ 'birth_month' ]
  @browser.select_list( :id, 'iDAY' ).select business[ 'birth_day' ]
  @browser.text_field( :id, 'iY' ).set business[ 'birth_year' ]
  @browser.select_list( :id, 'iState' ).select business[ 'state_full' ]
  @browser.text_field( :id, 'iPC' ).set business[ 'zip' ]
  @browser.select_list( :id, 'iTimezone' ).option( :index, 1 ).select # not important

  captcha_text = solve_captcha()
  @browser.text_field( :id, 'iCdHIPBInput0' ).set captcha_text
  
  @browser.button( :id, 'iSubmitButton' ).click

  # abc@hotmail.com is ready to go, continue
  continue_button = @browser.button(:id, 'iContinueButton')
  Watir::Wait::until do continue_button.exists? end
  continue_button.click

  # A password isn't enough
  @browser.text_field( :id, 'DisplayPhoneNumber' ).set business[ 'phone' ]
  @browser.text_field( :id, 'EmailAddress' ).set business[ 'email' ]
  @browser.button( :id, 'SaveBtn' ).click

  # Sign in
  @browser.text_field( :name, 'passwd' ).set business[ 'password' ]
  @browser.button( :value, 'Sign in' ).click

end