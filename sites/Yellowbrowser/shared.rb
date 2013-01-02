def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\yellowbrowser_captcha.png"
  obj = @browser.img( :xpath, '//*[@id="phoca-captcha"]' )
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
		@browser.text_field( :id, 'captcha').set captcha_code
		#@browser.button( :xpath => '/html/body/div/div[3]/div/div/form/table/tbody/tr[17]/td[2]/input').fire_event("onmousedown")
		#@browser.button( :xpath => '/html/body/div/div[3]/div/div/form/table/tbody/tr[17]/td[2]/input').fire_event("onmouseup")
		#@browser.button( :xpath => '/html/body/div/div[3]/div/div/form/table/tbody/tr[17]/td[2]/input').fire_event("onblur")		
		@browser.execute_script 'window.wFORMS.processedForm.Submit()'
		
		#		@browser.button( :name => "Submit").click
		sleep(2)
		if not @browser.text.include? "Image Verification is incorrect."
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

