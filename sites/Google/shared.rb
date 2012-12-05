def login ( data )
  site = 'https://plus.google.com/local'
  @browser.goto site
  
  if !!@browser.html['Recommended places']
    return true # Already logged in
  end
  
  page = Nokogiri::HTML(@browser.html)

  if not page.at_css('div.signin-box') # Check for <div class="signin-box">
    @browser.link(:text => 'Sign in').click
  end

  if !data['email'].empty? and !data['pass'].empty? 
    @browser.text_field(:id, "Email").set data['email']
    @browser.text_field(:id, "Passwd").set data['pass']
    @browser.button(:value, "Sign in").click
    @validation_error = @browser.span(:id,'errormsg_0_Passwd')
    # If user name or password is not correct
      if @validation_error.exist? 
        signup_generic( data )
      end
  else
    raise StandardError.new("You must provide both a username AND password for gplus_login!")
  end
end

def search_for_business( data )

	puts 'Search for the ' + data[ 'business' ] + ' business at ' + data[ 'zip' ] +  data['city']
	# 'https://plus.google.com/local' ) # Must be logged in to search
	@browser.goto('https://plus.google.com/local')

	@browser.text_field(:name, "qc").set data['business']
	@browser.text_field(:name, "qb").set data['city']
	@browser.button(:id,'gbqfb').click
	@browser.wait
	sleep(5)
end

def parse_results( data )
#Parse search result page
	page = Nokogiri::HTML(@browser.html)
	page_links = page.css("a").select
	applicableLinks = {}
	page_links.each do |link|
		if not link.nil?
			if not link['href'].nil? and !!link['href']["/about"]
				img = ""
				if not link.at('img').nil?
					img = link.at('img')['src']
				end
				applicableLinks[link.content] = [link['href'], img]
			end
		end
	end
	return applicableLinks.to_a
end

def retry_captcha
   @captcha_error = @browser.span(:id => 'errormsg_0_signupcaptcha')
   @captcha_error_msg = "The characters you entered didn't match the word verification. Please try again."
   #Check if there is any captcha mismatch error
   if @captcha_error.exist? && captcha_error.text.include?(@captcha_error_msg)
    image = "#{ENV['USERPROFILE']}\\citation\\google_captcha.png"
    obj = @browser.image(:src, /recaptcha\/api\/image/)
    puts "CAPTCHA source: #{obj.src}"
    puts "CAPTCHA width: #{obj.width}"
    obj.save image
    captcha_text = CAPTCHA.solve image, :manual
    @browser.text_field( :id => 'recaptcha_response_field' ).set captcha_text
    @browser.checkbox(:id => 'TermsOfService').set
    @browser.button(:value, 'Next step').click
   end
end
