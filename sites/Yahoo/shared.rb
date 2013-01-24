def sign_in(business)
  @browser = Watir::Browser.start 'https://login.yahoo.com/'
  @browser.text_field(:id, 'username').set business['email']
  @browser.text_field(:id, 'passwd').set business['password']
  @browser.button(:id, '.save').click
end

def retry_captcha(data)
  capSolved = false
  count = 1
  until capSolved or count > 5 do
    captcha_text = solve_captcha
    @browser.text_field( :id => 'captchaV5Answer' ).set captcha_text
    @browser.button( :id => 'IAgreeBtn' ).click if @browser.button( :id => 'IAgreeBtn' ).exist?
    @browser.button( :id => 'VerifyCollectBtn' ).click if @browser.button( :id => 'VerifyCollectBtn' ).exist?

     sleep(5)
    if not @browser.text.include? "Please try this code instead"
      capSolved = true
    end
    count+=1
   end
  if capSolved == true
    true
  else
  throw("Captcha was not solved")
  end
end


def solve_captcha
      file = "#{ENV['USERPROFILE']}\\citation\\yahoo_captcha.png"
      @browser.image(:class, 'captchaImage').save file
      text = CAPTCHA.solve file, :manual
  return text
end

