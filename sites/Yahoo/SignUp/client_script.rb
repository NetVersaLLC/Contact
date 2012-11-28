def sign_up_personal( business )
  puts 'Business is not found - Sign up for new account'
  @browser.goto( 'http://listings.local.yahoo.com/' )
  @browser.link( :text => 'Sign Up' ).click

  puts 'Sign up for new Yahoo account'
  @browser.link(:id => 'signUpBtn').click

  @browser.text_field( :id => 'firstname' ).set business[ 'first_name' ]
  @browser.text_field( :id => 'secondname' ).set business[ 'last_name' ]
  @browser.select_list( :id => 'gender' ).select business[ 'gender' ]
  @browser.select_list( :id => 'mm' ).select business[ 'month' ]
  @browser.text_field( :id => 'dd' ).set business[ 'day' ]
  @browser.text_field( :id => 'yyyy' ).set business[ 'year' ]
  @browser.select_list( :id => 'country' ).select business[ 'country' ]
  @browser.select_list( :id => 'language' ).select business[ 'language' ]
  @browser.text_field( :id => 'postalcode' ).set business[ 'zip' ]

  # .. select email
  @browser.text_field( :id => 'yahooid' ).clear # shows suggestions list; [click, flash]
  @browser.execute_script("document.getElementById('yahooid').focus();")

  Watir::Wait::until do
    @browser.element(:xpath, '//ol[@id="yidSug"]/li[1]/a').exists?
  end
  @browser.element(:xpath, '//ol[@id="yidSug"]//a[1]').click

  # .. remember the selected email to click in account confirmation email later
  Watir::Wait::until do @browser.span( :id => 'choosenyid' ).exists? end
  business[ 'business_email' ] = @browser.span( :id => 'choosenyid' ).text

  # or browser.ol( :id => 'yidSug' ).li( :index => 0 ).click;
  # browser.find_elements_by_xpath("div[@id='yidsuggestion'/li[0]").click
  @browser.text_field( :id => 'password' ).set business[ 'password' ]
  @browser.text_field( :id => 'passwordconfirm' ).set business[ 'password' ]

  # .. skip alternate email
  @browser.select_list( :id, 'secquestion' ).select 'Where did you meet your spouse?'
  @browser.text_field( :id, 'secquestionanswer' ).set business[ 'secret_answer_1' ]
  @browser.select_list( :id, 'secquestion2' ).select 'Where did you spend your childhood summers?'
  @browser.text_field( :id, 'secquestionanswer2' ).set business[ 'secret_answer_2' ]

  file = "#{ENV['USERPROFILE']}\\citation\\yahoo_captcha.png"
  @browser.image(:class, 'captchaImage').save file
  text = CAPTCHA.solve file, :manual
  @browser.text_field( :id => 'captchaV5Answer' ).set text

  # @browser.text_field( :id => 'captchaV5Answer' ).set 'Captcha'
  sleep 12
  @browser.button( :id => 'IAgreeBtn' ).click

  puts 'Continue to Yahoo Local'
  if not @browser.title == 'Yahoo! Registration Confirmation' #and @browser.text.include? 'Congratulations'
    raise StandardError.new( 'Not on Registration Confirmation page' )
  end

  # .. waits long here
  def homepage_checkbox; @browser.checkbox( :id => 'setHomepage' ) end
  if homepage_checkbox.exists? then homepage_checkbox.clear end

  @browser.button( :id => 'ContinueBtn' ).click

  RestClient.post "#{@host}/yahoo/save_email.json?auth_token=#{@key}&business_id=#{@bid}", :email => business['business_email'], :password => business['password'], :secret1 => business['secret_answer_1'], :secret2 => business['secret_answer_2']
end

sign_up_personal(data)

if @chained
  self.start("Yahoo/CheckListing")
end

true
