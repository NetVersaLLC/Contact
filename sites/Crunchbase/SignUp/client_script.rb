def process_crunchbase_signup(profile)
	puts 'Sign up for new Crunchbase account'

  @browser.text_field(:id, "user_name").set profile['name']
  @browser.text_field(:id, "user_username").set profile['username']
  @browser.text_field(:id, "user_password").set profile['password']
  @browser.text_field(:id, "user_password_confirmation").set profile['password']
  @browser.text_field(:id, "user_email_address").set profile['email']
  @browser.text_field(:id, "user_twitter_username").set profile['twitter']
  @browser.text_field(:id, "user_homepage_url").set profile['homepage']

  enter_captcha 

  @browser.wait_until {@browser.h1(:class => 'h1_first', :text => 'Connect with Facebook').exists?}

  if profile['use_facebook'] == true
    @browser.div(:id => "facebook_link_holder").img(:index => 0).click
  else
    @browser.link(:text => /Skip this step/).click
  end

	puts 'Signup is Completed'
end
goto_signup_page
process_crunchbase_signup(data)
