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
  @browser.wait_until {
    @browser.span(:text, 'Key to ratings').exists?
  }
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

  ["vT Yi uta IA","w0 pBa", "TBa", "mFa PBa QBa", "oFa CX", "lFa OBa"].each do |linkClass|
    @browser.div(:class => linkClass).fire_event "onmouseover"
    @browser.div(:class => linkClass).click
  end
	@browser.div(:class => "W0 pBa").click

	@browser.text_field(:xpath, "//input[contains(@label, 'Primary phone number')]").set(business['phone'])
	@browser.div(:class => "a-f-e c-b c-b-M LC").click
	while not @browser.div(:class, "zX").exists? # No matches located
		sleep(3)
		puts 'Waiting on "No matches located" to appear.'
	end

	@browser.div(:class => "rta Si").click
	@browser.text_field(:xpath, "//input[contains(@label, 'Business name')]").set(business['business_name'])
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
