def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\cornerstonesworld_captcha.png"
  obj = @browser.img( :xpath, '//*[@id="cap"]' )
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
		@browser.text_field( :id, 'capchacl').set captcha_code
		@browser.checkbox( :id => 'agreecl').click
		@browser.text_field( :id => 'pwdcl').set data[ 'password' ]
		@browser.text_field( :id => 'pwdccl').set data[ 'password' ]
		@browser.button(:name => 'register').click
		sleep(4)
		if not @browser.text.include? "SECURITY AUTHENTICATION FAILED! Please try again!"
			capSolved = true
		end	  
	count+=1
	end
	if capSolved == true
		true
	else
		throw("Captcha was not solved")
	end
end

