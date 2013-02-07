def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\showmelocal_captcha.png"
  obj = @browser.img( :xpath, '//*[@id="imgWVI"]' )
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
		@browser.text_field( :id, 'txtWordVeritication').set captcha_code
		@browser.button(:id => 'cmdSave').click
		sleep(2)
		if not @browser.text.include? "Verification word failed."
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

