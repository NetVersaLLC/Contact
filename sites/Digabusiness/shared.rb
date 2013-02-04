def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\matchpoint_captcha.png"
  obj = @browser.img( :xpath, '/html/body/div[3]/div[2]/div/div[2]/div/form/table/tbody/tr[28]/td[2]/img' )
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
		@browser.text_field( :id => 'CAPTCHA').set captcha_code
		@browser.button( :name => 'submit').click
		sleep(2)
		if not @browser.text.include? "Invalid code."
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


