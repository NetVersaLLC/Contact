def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\yellowbot_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div[3]/div/div[2]/div/div/div/div/div/div[2]/form/fieldset/div/div/table/tbody/tr[2]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end

def solve_captcha2
  image = "#{ENV['USERPROFILE']}\\citation\\yellowbot2_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div[3]/div/div[2]/div/div/div/div/div/div/div/form/div/div/table/tbody/tr[2]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end


def enter_captcha( data )

	capSolved = false
	count = 1
	until capSolved or count > 5 do
		captcha_code = solve_captcha
		@browser.text_field( :id => 'recaptcha_response_field' ).set captcha_code
		@browser.button( :name => 'subbtn' ).click
		
		if @browser.div( :class, 'error').exists?
			errors = @browser.div( :class, 'error').text
			puts( errors )
		end

		if not @browser.text.include? "Please correct the errors below and resubmit"
			capSolve = true
		end

		  @browser.text_field( :id => 'reg_password' ).set data[ 'password' ]
		  @browser.text_field( :id => 'reg_password2' ).set data[ 'password' ]		
	count+=1	
	end

	if capSolve == true
		true
	else
		throw("Captcha was not solved")
	end
end



def enter_captcha_add_business( data )

	capSolved = false
	count = 1
	until capSolved or count > 5 do
		captcha_code = solve_captcha
		@browser.text_field( :id => 'recaptcha_response_field' ).set captcha_code
		@browser.button( :name => 'subbtn' ).click
		
		if @browser.div( :class, 'corr_error').exists?
			errors = @browser.div( :corr_error, 'error').text
			puts( errors )
		end

		if not @browser.text.include? "Incorrect. Try again."
			capSolve = true
		end
  	
	count+=1	
	end

	if capSolve == true
		true
	else
		throw("Captcha was not solved")
	end
end

