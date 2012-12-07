def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\expressupdateusa_captcha.png"
  obj = @browser.image( :xpath, '/html/body/div/div/div[2]/div/div/form/div/div/div[21]/img' )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end

def sign_in( data )
	@browser.goto( 'https://listings.expressupdateusa.com/Account/SignIn' )
	@browser.text_field( :name, 'Email' ).set data[ 'business_email' ]
	@browser.text_field( :name, 'Password' ).set data[ 'password' ]
	@browser.button( :id, 'SignInNowButton').click

end

def clean_time( time )
time = time.gsub( "AM", " AM")
time = time.gsub( "PM", " PM")
if time[0,1] == '0'
	time[0] = ''
end
time
end
