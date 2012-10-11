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
	retryable(:tries => 5, :on => [ Watir::Exception::UnknownObjectException, Timeout::Error ] ) do
		yield
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
	
  if !business['email'].empty? and !business['pass'].empty? # Watir::Exception::UnknownObjectException
    @browser.text_field(:id, "Email").set(business['email'])
    @browser.text_field(:id, "Passwd").set(business['pass'])
    @browser.button.focus
    @browser.button.send_keys :return
  else
    raise StandardError.new("You must provide both a username AND password for gplus_login!")
  end
end

