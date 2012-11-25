def verify_account_name_available( data )
	
  #Verify user name is available or not
  @browser.text_field(:id, "GmailAddress").value = data['email_name']
  @browser.div(:id,'gmail-address-form-element').span(:text,'@gmail.com').click
  @browser.text_field(:id, "GmailAddress").send_keys :tab
  @browser.span(:id, "errormsg_0_GmailAddress").text != ""
  if @browser.span(:id, "errormsg_0_GmailAddress") != ""
    puts 'Business Name is already used as a google username.  Need alternate!'
    if business.has_key?('acceptable_alternates')
      data['acceptable_alternates'].each do |new_name|
      @browser.text_field(:id, "GmailAddress").value = new_name
      @browser.text_field(:id, "GmailAddress").send_keys :tab
      if not @browser.span(:id, "errormsg_0_GmailAddress").exists?
        break
      end
      end
    else
      fail StandarError.new('Business Name is already used as a google username.  Need alternate!')
    end
  end
end

def signup_generic( data )

  site = 'https://accounts.google.com/SignUp'
	
  #Launch Browser
  @browser.goto site

  @browser.text_field(:id, "FirstName").value = data['first name']
  @browser.text_field(:id, "LastName").value = data['last name']
	
  #Verify if username is available
  verify_account_name_available( business )
	
  @browser.text_field(:id, "Passwd").value = data['pass']
  @browser.text_field(:id, "PasswdAgain").value = data['pass']

  # Number of times to select month
  @browser.div(:class => "goog-inline-block goog-flat-menu-button-dropdown", :index => 0).click
  @browser.div(:text, "#{data['birthmonth']}").click
  @browser.text_field(:id, "BirthDay").value = data['birthday']
  @browser.text_field(:id, "BirthYear").value = data['birthyear']

  # Gender
  @browser.div(:class => "goog-inline-block goog-flat-menu-button-dropdown", :index => 1).click
  @browser.div(:text, "#{data['gender']}").click
  @browser.text_field(:id, "RecoveryPhoneNumber").set data['phone']
  #~ @browser.text_field(:id, "RecoveryEmailAddress").value = data['alt_email']
	
  @browser.div(:class => "goog-inline-block goog-flat-menu-button-dropdown", :index => 2).click
  @browser.div(:text, "#{data['country']}").click
  @browser.checkbox(:id,'TermsOfService').set
	
  #Captcha Code
  file = Tempfile.new('image.png')
  file.close
  

  @browser.image(:src, /recaptcha\/api\/image/).save file.path
  text = CAPTCHA.solve file.path
  @browser.text_field( :id => 'captcha_text' ).set text
	
  @browser.button(:value, 'Next step').click
  @browser.wait
	

  if @browser.text.include?('Verify your account')
    @browser.text_field(:id, 'signupidvinput').set data[ 'phone' ]
    @browser.radio(:id,'signupidvmethod-sms').set
    @browser.button(:value,'Continue').click
    if @browser.span(:class,'errormsg').exist? 
      puts "#{@browser.span(:class,'errormsg').text}"
    end
    if @browser.text_field(:id,'verify-phone-input').exist?
      @browser.text_field(:id,'verify-phone-input').set data[ 'pass-code' ]
      @browser.button(:value,'Continue').click
        if @browser.span(:class,'errormsg').exist? 
    	puts "#{@browser.span(:class,'errormsg').text}"
        end
    end
  else
    throw("Initial Registration is not successful")
  end	
end

signup_generic(data)