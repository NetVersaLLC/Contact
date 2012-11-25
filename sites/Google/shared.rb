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