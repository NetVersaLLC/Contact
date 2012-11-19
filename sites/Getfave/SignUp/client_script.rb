# Launch url
@url = 'https://www.getfave.com'
@browser.goto(@url)

begin

#Check for existing session
@sign_out = @browser.link(:text,'Log Out')

if @sign_out.exist?
	@sign_out.click
end

#Sign in
@sign_in = @browser.link(:text,'Log In/Join')
@sign_in.click
@browser.link(:text,'Log In/Join').click
@browser.text_field(:id,'session_email').set data[ 'email' ]
@browser.text_field(:id,'session_password').set data[ 'password' ]
@browser.button(:value,'Log In').click
#~ throw("Login unsuccessful") if @sign_in.exist?

# Check for login error
@login_error = @browser.div(:class,'container error')

#Sign up if user doesn't exist
if @login_error.exist? 
	@browser.link(:text,'create a new one,').click
	@browser.text_field(:id,'user_name').set data[ 'name' ]
	@browser.text_field(:id,'user_email').set data[ 'email' ]
	@browser.text_field(:id,'user_password').set data[ 'email' ]
	@browser.button(:value,'Join Us').click
#	@browser.goto(@url)
	puts ("Signup successful. Verify email to continue")
	true
end

rescue Exception => e
  puts("Exception Caught in Business Listing")
  puts(e)
end
