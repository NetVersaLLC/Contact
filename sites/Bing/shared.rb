#require 'gp_requires'

def retryable(options = {}, &block)
  opts = { :tries => 1, :on => Exception }.merge(options)
  retry_exceptions, retries = opts[:on], opts[:tries]
  exceptLogger = []
  begin
    return yield
  rescue Exception => ex # FIXME # Currently catches everything... need to figure out 'rescue *retry_exceptions
    exceptLogger += [ex.inspect]
    sleep(3)
    retry if (retries -= 1) > 0
  raise StandardError.new("You maxed out on retries!  These error's came back: \n#{exceptLogger.join("\n")}")
  end
end

def watir_must( &block )
  retryable(:tries => 3, :on => [ Watir::Exception::UnknownObjectException, Timeout::Error ] ) do
    yield
  end
end



captcha_types = { :sign_up, :add_listing }
def solve_captcha( type )

  if :sign_up == type then
    
    image = "#{ENV['USERPROFILE']}\\citation\\bing_signup_captcha.png"
    obj = @browser.image(:xpath, "//div/table/tbody/tr/td/img[1]")

  elsif :add_listing == type then

    image = "#{ENV['USERPROFILE']}\\citation\\bing_add_listing_captcha.png"
    obj = @browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).image()

  else
    raise StandardError( 'Invalid capctha type specified' )
  end
  

  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual

end

def sign_in( business )

  @browser.goto( 'https://login.live.com/' )

  email_parts = {}
  email_parts = business[ 'hotmail' ].split( '.' )

  @browser.input( :name, 'login' ).send_keys email_parts[ 0 ]
  @browser.input( :name, 'login' ).send_keys :decimal
  @browser.input( :name, 'login' ).send_keys email_parts[ 1 ]
  # TODO: check that email entered correctly since other characters may play a trick
  @browser.text_field( :name, 'passwd' ).set business[ 'password' ]
  # @browser.checkbox( :name, 'KMSI' ).set
  @browser.button( :name, 'SI' ).click

end

def search_for_business( business )

  @browser.goto( 'http://www.bing.com/businessportal/' )
  puts 'Search for the ' + business[ 'name' ] + ' business at ' + business[ 'city' ] + ' city'
  @browser.link( :text , 'Get Started Now!' ).click

  #sleep 4 # seems that div's are not loaded quickly simetimes
  watir_must do @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'name' ] end
  @browser.div( :class , 'LiveUI_Area_Find___City' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'city' ]
  @browser.div( :class , 'LiveUI_Area_Find___State' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'state_short' ]
  @browser.div( :class , 'LiveUI_Area_Search_Button LiveUI_Short_Button_Medium' ).click
  #sleep 4
  
end

def goto_listing( business )
  @browser.goto( 'http://www.bing.com/businessportal/' )
  @browser.link( :text , 'Sign In Here').click

  Watir::Wait::until do
    @browser.div( :text, 'LISTINGS' ).exists?
  end

  @browser.div( :class, 'LiveUI_Area_Items_Repeating' ).div( :text, business['name'] ).click
end


def solve_captcha2
  image = "#{ENV['USERPROFILE']}\\citation\\bing1_captcha.png"
  obj = @browser.img( :xpath, '//div/table/tbody/tr/td/img[1]' )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end

def enter_captcha

	capSolved = false
	count = 1
	until capSolved or count > 5 do
		captcha_code = solve_captcha2	
		@browser.text_field( :class => 'spHipNoClear hipInputText' ).set captcha_code
		@browser.button( :title => /I accept/i ).click
		sleep(2)
		if not @browser.text.include? "The characters didn't match the picture. Please try again."
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
