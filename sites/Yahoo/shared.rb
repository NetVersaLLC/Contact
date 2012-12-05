def sign_in(business)
  @browser = Watir::Browser.start 'https://login.yahoo.com/'
  @browser.text_field(:id, 'username').set business['email']
  @browser.text_field(:id, 'passwd').set business['password']
  @browser.button(:id, '.save').click
end

def retry_captcha
   @captcha_error = @browser.div(:id => 'captchaFld')
   @captcha_error_msg = "Please try this code instead"
   #Check if there is any captcha mismatch
   if @captcha_error.exist? && @captcha_error.text.include?(@captcha_error_msg)
      file = "#{ENV['USERPROFILE']}\\citation\\yahoo_captcha.png"
      @browser.image(:class, 'captchaImage').save file
      text = CAPTCHA.solve file, :manual
      @browser.text_field( :id => 'captchaV5Answer' ).set text
      sleep 12
      @browser.button( :id => 'IAgreeBtn' ).click
   end
end

