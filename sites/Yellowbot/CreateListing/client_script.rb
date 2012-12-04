@browser.goto( "https://www.yellowbot.com/signin/register" )

  @browser.text_field( :id => 'reg_email' ).set data[ 'email' ]
  @browser.text_field( :id => 'reg_email_again' ).set data[ 'email' ]

  @browser.text_field( :id => 'reg_name' ).set data[ 'username' ]
  @browser.text_field( :id => 'reg_password' ).set data[ 'password' ]
  @browser.text_field( :id => 'reg_password2' ).set data[ 'password' ]
  
  @browser.checkbox( :name => 'tos' ).set
  @browser.checkbox( :name => 'opt_in' ).clear
captcha_text = solve_captcha()
@browser.text_field( :id => 'recaptcha_response_field' ).set captcha_text

  @browser.button( :name => 'subbtn' ).click
	if @browser.text.include? 'Welcome to YellowBot!'
		puts("Registered! Confirming email...")
		true
	end


def create_business( data )
@browser.goto( 'http://www.yellowbot.com/submit/newbusiness' )

@browser.text_field( :name, 'name').set data['business']
@browser.text_field( :name, 'phone_number').set data['phone']
@browser.text_field( :name, 'address').set data['address']
@browser.text_field( :name, 'fax_number').set data['fax_number']
@browser.text_field( :name, 'city_name').set data['city_name']
@browser.text_field( :name, 'state').set data['state']
@browser.text_field( :name, 'zip').set data['zip']
@browser.text_field( :name, 'tollfree_number').set data['tollfree_number']
@browser.text_field( :name, 'hours_open').set data['hours_open']
@browser.text_field( :name, 'email').set data['email']
@browser.text_field( :name, 'website').set data['website']

captcha_text2 = solve_captcha2()
@browser.text_field( :name, 'recaptcha_response_field').set captcha_text2

@browser.button( :name, 'subbtn').click

if @browser.text.include? 'Thank you for submitting a new business.'

	puts( 'Business listing created!' )
	true
else 
	throw( 'There was an error listing the business' )
end


end

create_business(data)

true
