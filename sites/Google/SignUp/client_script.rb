def verify_account_name_available( business )
	# site = 'https://accounts.google.com/SignUp'
  @name = business['email_name']
	@browser.text_field(:id, "GmailAddress").set(@name)
	@browser.send_keys :tab
	sleep(4)
	if @browser.span(:id, "errormsg_0_GmailAddress").visible?
		puts 'Business Name is already used as a google username.  Need alternate!'
		if business.has_key?('acceptable_alternates')
			business['acceptable_alternates'].each do |new_name|
				@browser.text_field(:id, "GmailAddress").set(new_name)
				@browser.send_keys :tab
				sleep(4)
				if not @browser.span(:id, "errormsg_0_GmailAddress").exists?
          @name = new_name
					break
				end
			end
		else
			throw('Business Name is already used as a google username.  Need alternate!')
		end
	end

  @name
end

def signup_generic( business )
  @browser.goto 'https://accounts.google.com/SignUp'
	
	@browser.text_field(:id, "FirstName").set(business['first name'])
	@browser.text_field(:id, "LastName").set(business['last name'])
	
	@account_name = verify_account_name_available( business )
	
	@browser.text_field(:id, "Passwd").set business['password']
	@browser.text_field(:id, "PasswdAgain").set business['password']
	
	@browser.send_keys :tab
	# Number of times to select month
	8.times { @browser.send_keys :arrow_down; }
	
	@browser.send_keys :tab
	@browser.text_field(:id, "BirthDay").set business['birthday']
	@browser.text_field(:id, "BirthYear").set business['birthyear']
	
	@browser.send_keys :tab
	# Gender
	3.times { @browser.send_keys :arrow_down; }
	
	#@browser.text_field(:id, "RecoveryPhoneNumber").set business['phone_number']
	#@browser.text_field(:id, "RecoveryEmailAddress").set business['email']

	# TODO Captcha
	#<img class="decoded" alt="https://www.google.com/recaptcha/api/image?c=03AHJ_VushQ-GsHbv6xNOVQfzKE8jfDFrqBB1GSvfA55jaI2PNtpVGuM1Eo2jSjd0DSezOCDSvvDKojdrEv020d_5j9Tgv0eNLRn0KEJ8rJ4c724UmGb1oH4kLMoYx9mMPdstYXdtnaFAanpTkgJS1PBQcSVY1ZhqCRg" src="https://www.google.com/recaptcha/api/image?c=03AHJ_VushQ-GsHbv6xNOVQfzKE8jfDFrqBB1GSvfA55jaI2PNtpVGuM1Eo2jSjd0DSezOCDSvvDKojdrEv020d_5j9Tgv0eNLRn0KEJ8rJ4c724UmGb1oH4kLMoYx9mMPdstYXdtnaFAanpTkgJS1PBQcSVY1ZhqCRg">
  file = Tempfile.new('image.png')
  file.close
  @browser.image(:src, /recaptcha\/api\/image/).save file.path
  text = CAPTCHA.solve file.path
  @browser.text_field( :id => 'captcha_text' ).set text
	
	$browser.button(:id, "submitbutton").focus
	$browser.button(:id, "submitbutton").send_keys :return

  RestClient.post "#{@host}/google/save_email?auth_token=#{@key}&business_id=#{@bid}", :email => "#{@name}@gmail.com", :password => business['password']
end

signup_generic(data)

true
