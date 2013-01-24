def sign_in(business)
  @browser = Watir::Browser.start 'https://login.yahoo.com/'
  @browser.text_field(:id, 'username').set business['email']
  @browser.text_field(:id, 'passwd').set business['password']
  @browser.button(:id, '.save').click
end

def retry_captcha(captcha_text)
   @captcha_error = @browser.div(:id => 'captchaFld')
   @captcha_error_msg = "Please try this code instead"
   count = 1
# Decode captcha code until its decoded (Maximum 5 times)
   while @captcha_error.exist? do
      @browser.text_field( :id => 'captchaV5Answer' ).set captcha_text
      @browser.button( :id => 'IAgreeBtn' ).click if @browser.button( :id => 'IAgreeBtn' ).exist?
      @browser.button( :id => 'VerifyCollectBtn' ).click if @browser.button( :id => 'VerifyCollectBtn' ).exist?
      count+=1
      break if count == 5
   end
end

def solve_captcha
      file = "#{ENV['USERPROFILE']}\\citation\\yahoo_captcha.png"
      @browser.image(:class, 'captchaImage').save file
      text = CAPTCHA.solve file, :manual
  return text
end

