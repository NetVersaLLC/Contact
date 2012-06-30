require "rubygems"
require "watir-webdriver"

#### The all encompassing Craigslist Handler ####
# Ask Daniel P. Clark if you have any questions webmaster@6ftdan.com

# NOTE TO SELF, We can implement a check to see if the terms page ever shows up


####   NOT USED   ####
# business = {}
# business['email'] = "the_matrix_emp@yahoo.com"
# business['password'] = "jonsproject"
#### END NOT USED ####

#--------------

$captcha_credentials = ['get your own', 'dadgum credentials']
$timeout_length = 330 # Default is 30
$default_browser = :ff

#--------------

####   MAP   ####
# Walkthrough_Signup : The logical order in which to create an account A.K.A. Functions by order.
Walkthrough_Signup = %w{ craigslist_signup craigslist_retrieve_email_link craigslist_email_to_new_password craigslist_terms_of_use }
# Walkthrough_Post : The logical order in which to create a post A.K.A. Functions by order.
Walkthrough_Post = %w{ craigslist_login }
#### END MAP ####


#### DO NOT MODIFY ####
$b = Class.new
#######################

# load_link( wait time ) : INTERNAL FUNCTION : Allows pages to load by waiting for set time
def load_link(waittime)
	begin
		Timeout::timeout(waittime)  do
		yield
	end
	rescue Timeout::Error => e
		puts "Craigslist page load timed out: #{e}"
		retry
	end
end

# browser_start(Watir Browser Object) : INTERNAL FUNCTION : Select which browser you want to open, and open it.
def browser_start(browser_type = $default_browser)
	if not $b.respond_to?(:htmls)
		$b = Watir::Browser.new browser_type
	end
end

# craigslist_login( AccountEmail, MyPassword) : Login to existing account on Craigslist.
def craigslist_login(email = "", pass = "")
	$site = 'https://accounts.craigslist.org/' # if $site.nil?
	browser_start
	load_link($timeout_length) { $b.goto $site }
	if !email.empty? and !pass.empty?
		$b.text_field(:name, "inputEmailHandle").set(email)
		$b.text_field(:name, "inputPassword").set(pass)
		$b.button(:type, "submit").click
		if $b.p(:class, "error").exists?
			raise StandardError.new("Craigslist doesn't like your choice of username and password!")
		end
	else
		raise StandardError.new("You must provide both a username AND password for Craigslist login!")
	end
end

# craigslist_retrieve_email_link : NOT YET IMPLEMENTED
def craigslist_retrieve_email_link
	raise NotImplementedError.new('craigslist_retrieve_email_link is Not Yet Implemented')
end

# craigslist_email_to_set_password( Link From email, New Password ) : Follow the signup e-mail, set the password
def craigslist_email_to_new_password(elink = "", pass = "")
	$site = elink
	browser_start
	load_link($timeout_length) { $b.goto $site }
	
	if not pass.length >= 6:
		raise IOError.new('Password length for set new password isn\'t 6 characters or greater!')
	end
	
	$b.text_field(:name, "inputNewPassword").set(pass)
	$b.text_field(:name, "inputNewPasswordRetype").set(pass)
	$b.button(:type, "submit").click
	if $b.h3(:text, "You have successfully set a new password for this account.") # UNTESTED June 30th, 2012
		craigslist_terms_of_use
	else
		raise StandardError.new('Craigslist : We did not detect password successful page. ... We think.')
	end
end

# craigslist_after_signup_password : You must agree to the terms, simple click.
def craigslist_terms_of_use # The Terms
	$site = 'https://accounts.craigslist.org/login/tou' # if $site.nil?
	browser_start
	load_link($timeout_length) { $b.goto $site }
	$b.button(:value, "I ACCEPT").click #@driver.find_element(:css, "input[type=\"submit\"]").click 
end

# craigslist_signup( e-mail ) : Create a new account on Craigslist.
def craigslist_signup(email = "")
	$site = 'https://accounts.craigslist.org/signup' # if $site.nil?
	browser_start
	load_link($timeout_length) { $b.goto $site }

	$b.text_field(:name, "emailAddress").set(email)
	
	require "deathbycaptcha"

	# CAPTCHA # client = DeathByCaptcha.socket_client($captcha_credentials[0], $captcha_credentials[1])
	# CAPTCHA # client.config.is_verbose = true # For Debugging Purposes
	# CAPTCHA !! HAS NO EFFECT # client.config.default_timeout = $timeout_length
	# WATIR GOOD # captcha_url_to_crack = $b.script(:index, 1).attribute_value("src")
	# CAPTCHA DOESN'T WORK / TIME OUT (maybe cellular internet to slow?) # client.decode captcha_url_to_crack
	# CAPTCHA # puts "captcha id: #{captcha_response['captcha']}, solution: #{captcha_response['text']}, is_correct: #{captcha_response['is_correct']}}"

	$b.input(:value, "create account").click
end
#### NOTES FOR craigslist_signup ####
# For URL https://accounts.craigslist.org/signup
# SUCCESSFUL! # puts $b.div(:id, "recaptcha_image").exists?
# SUCCESSFUL! # puts $b.input(:value, "create account").exists?
# NOSCRIPT # puts $b.frame.form.img.exists?
# NOSCRIPT # puts $b.input(:value, "I&#39;m a human").exists?
#### --------------------------- ####

#craigslist_login("George@google.com","HisPassword")
#craigslist_login("the_matrix_emp@yahoo.com","jonsproject")
#craigslist_terms_of_use
