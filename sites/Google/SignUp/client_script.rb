def signup_generic( business )
	site = 'https://accounts.google.com/SignUp'
	
	if not @browser.respond_to?(:htmls)
		browser_instance
	end
	
	watir_must do
		@browser.goto site
	end
	
	@browser.text_field(:id, "FirstName").set(business['first name'])
	@browser.text_field(:id, "LastName").set(business['last name'])
	
	verify_account_name_available( business )
	
	@browser.text_field(:id, "Passwd").set('passwd')
	@browser.text_field(:id, "PasswdAgain").set('passwd')
	
	@browser.send_keys :tab
	# Number of times to select month
	8.times { @browser.send_keys :arrow_down; }
	
	@browser.send_keys :tab
	@browser.text_field(:id, "BirthDay").set('birthday')
	
	@browser.text_field(:id, "BirthYear").set('birthyear')
	
	@browser.send_keys :tab
	# Gender
	3.times { @browser.send_keys :arrow_down; }
	
	@browser.text_field(:id, "RecoveryPhoneNumber").set('phone number')
	
	@browser.text_field(:id, "RecoveryEmailAddress").set('email')
	
	
	# TODO Captcha
	#<img class="decoded" alt="https://www.google.com/recaptcha/api/image?c=03AHJ_VushQ-GsHbv6xNOVQfzKE8jfDFrqBB1GSvfA55jaI2PNtpVGuM1Eo2jSjd0DSezOCDSvvDKojdrEv020d_5j9Tgv0eNLRn0KEJ8rJ4c724UmGb1oH4kLMoYx9mMPdstYXdtnaFAanpTkgJS1PBQcSVY1ZhqCRg" src="https://www.google.com/recaptcha/api/image?c=03AHJ_VushQ-GsHbv6xNOVQfzKE8jfDFrqBB1GSvfA55jaI2PNtpVGuM1Eo2jSjd0DSezOCDSvvDKojdrEv020d_5j9Tgv0eNLRn0KEJ8rJ4c724UmGb1oH4kLMoYx9mMPdstYXdtnaFAanpTkgJS1PBQcSVY1ZhqCRg">
	
	
	$browser.button(:id, "submitbutton").focus
	$browser.button(:id, "submitbutton").send_keys :return

end

def verify_account_name_available( business )

	# site = 'https://accounts.google.com/SignUp'
	
	@browser.text_field(:id, "GmailAddress").set(business['business'])
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
					break
				end
			end
		else
			fail StandarError.new('Business Name is already used as a google username.  Need alternate!')
		end
	end
	
end

def login ( business )

	site = 'https://plus.google.com/local'
	
	watir_must do
		@browser.goto site
	end
	
	if !!@browser.html['Recommended places']
		return true # Already logged in (IE/watir behaviour)
	end
	
	page = Nokogiri::HTML(@browser.html)
	
	if not page.at_css('div.signin-box') # Check for <div class="signin-box">
		watir_must do @browser.link(:text => 'Sign in').click; end
	end
	
	watir_must do
		if !business['email'].empty? and !business['pass'].empty? # Watir::Exception::UnknownObjectException
			@browser.text_field(:id, "Email").set(business['email'])
			@browser.text_field(:id, "Passwd").set(business['pass'])
			@browser.button.focus
			@browser.button.send_keys :return
		else
			raise StandardError.new("You must provide both a username AND password for gplus_login!")
		end
	end
	
end

def search_for_business( business )

	puts 'Search for the ' + business[ 'business' ] + ' business at ' + business[ 'zip' ] + ' zip location'
	# 'https://plus.google.com/local' ) # Must be logged in to search
	
	@browser.text_field(:name, "qc").set(business['business'])
	@browser.text_field(:name, "qb").set(business['zip'])
	if @browser.respond_to?(:ie)
		@browser.button(:id, "gbqfb").click
	else
		@browser.button(:xpath, "//button[contains(@aria-label , 'Google Search')]").focus
		@browser.button(:xpath, "//button[contains(@aria-label , 'Google Search')]").send_keys :return
	end
	
end

def wait_for_results

	if @browser.respond_to?(:ie)
		@browser.wait_until {
	  		@browser.span(:text, 'Key to ratings').exists?
	  	}
	else
		watir_must do
	  		@browser.wait_until {
	  			@browser.span(:text, 'Key to ratings').exists?
		  	}
		end
	end
	
end

def parse_results( business )

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

def discern_parse_business_exist?( applicableLinks, business )

	return applicableLinks.collect { |listing| listing[0] == business['business'] }.member?(true)
	
end

def claim_business( applicableLinks )

	puts "Selcting found business from search results."

	listIndx = applicableLinks.collect { |listing| listing[0] == business['business'] }.find_index(true)
	@browser.link(:href, applicableLinks[listIndx][1][0]).click

	puts 'Claiming as business owner'

	until !!@browser.execute_script("return document.location.toString();")[/.*about/]
		sleep 3 # The url has to be the business page... wait for it... wait for it.
	end

	@browser.div(:class => "a-f-e c-b c-b-T BNa FPb Ppb").click # Manage this page

	sleep 5

	@browser.radio(:value => "edit").click # Edit

	@browser.button(:name, "continue").click # This confirms the claim (D.P.C.) I have not ventured beyond here.
	
	# TODO Confirm following page.
end

def create_business( business )

	puts 'Business is not found - Creating business listing'
	
	# select link on bottom of page https://plus.google.com/pages/create
	@browser.goto "https://plus.google.com/pages/create"

	if @browser.respond_to?(:ie) # TODO FIXME
		["vT Yi uta IA","w0 pBa", "TBa", "mFa PBa QBa", "oFa CX", "lFa OBa"].each do |linkClass|
			@browser.div(:class => linkClass).fire_event "onmouseover"
			@browser.div(:class => linkClass).click
		end
	end
	@browser.div(:class => "W0 pBa").click

	@browser.text_field(:xpath, "//input[contains(@label, 'Primary phone number')]").set(business['phone'])
	@browser.div(:class => "a-f-e c-b c-b-M LC").click
	while not @browser.div(:class, "zX").exists? # No matches located
		sleep(3)
		puts 'Waiting on "No matches located" to appear.'
	end

	@browser.div(:class => "rta Si").click
	@browser.text_field(:xpath, "//input[contains(@label, 'Business name')]").set(business['business'])
	@browser.text_field(:xpath, "//input[contains(@label, 'Address')]").focus
	@browser.text_field(:xpath, "//input[contains(@label, 'Address')]").set(business['address'])
	@browser.send_keys :tab
	@browser.send_keys :tab

	# TODO This should be changed to a list of business class types, the index will be th count + 1
	12.times { @browser.send_keys :arrow_down; }

	@browser.div(:id, ":b2").click
	@browser.div(:class => "c-I-Fc").click # Agree to the terms
	sleep(1)
	@browser.div(:class => "a-f-e c-b c-b-M g-s-Yf-Kf-b").click
	sleep(8) # CSS error page should apear.  This is okay.

	# TODO add company image and click continue
	# image_path = ContactJob.get_logo(business['image'])
        image_path = File.expand_path('.\\bus250x250.png')
	@browser.div(:class, "a-f-e c-b c-b-T MD Wza a-p").click
	@browser.div(:class, "a-f-e c-b c-b-M c-b-Na c-b-C").click

        # @browser.upload(:id, 'logo').set image_path
        # @browser.div(:class, 'signup').click
	
end

def main( business )

	if not @browser.respond_to?(:htmls)
		browser_instance
	end
	
	if @browser.respond_to?(:ie)
		@browser.bring_to_front
		@browser.set_fast_speed
		@browser.maximize
	end

	#signup_generic( business ) # New Account
	 
	login( business )
	 
	search_for_business( business )
	wait_for_results
	
	@linkResults = parse_results( business )
	
	if discern_parse_business_exist?( @linkResults, business )
		claim_business( @linkResults )
	else
		create_business( business )
	end
  
	#ContactJob.start( 'Google/Verify' )
	true

end

if main( eval( File.open('data_generator.rb').read ) ) == true
	true
else
	false
end
