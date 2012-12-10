

def sign_up( data )

  # assert url starts with 'https://listings.expressupdateusa.com/Account/Register'
  puts 'Signing up with email: ' + data[ 'personal_email' ]

  @browser.text_field( :id, 'Email' ).set data[ 'personal_email' ]
  @browser.text_field( :id, 'Password' ).set data[ 'personal_password' ]
  @browser.text_field( :id, 'ConfirmPassword' ).set data[ 'personal_password' ]

  @browser.text_field( :id, 'Phone' ).set data[ 'business_phone' ]
  @browser.text_field( :id, 'BusinessName' ).set data[ 'business_name' ]
  @browser.text_field( :id, 'FirstName' ).set data[ 'personal_firstname' ]
  @browser.text_field( :id, 'LastName' ).set data[ 'personal_lastname' ]
  
  @browser.select_list( :id, 'State' ).select data[ 'business_state' ]
  @browser.text_field( :id, 'Captcha').set solve_captcha
  @browser.checkbox( :id, 'DoesAcceptTerms' ).set
  @browser.button( :class, 'RegisterNowButton' ).click

  # If no return URl then 'Thank You for Registering with Express Update. An activation email sent!'

RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data['email'], 'account[password]' => data['password'], 'model' => 'Expressupdateusa'

true 

if @chained
	  self.start("Expressupdateusa/Verify")
end


end


@browser.goto('https://listings.expressupdateusa.com/Account/Register')
sign_up( data )

