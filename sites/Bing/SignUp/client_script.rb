def get_email_name( business )
  business[ 'name' ].downcase.delete( ' ' ).strip + '_' + rand( 100 ).to_s
end

def sign_up( business )
  @browser.text_field(  :id, 'iFirstName' ).set      business[ "first_name" ]
  @browser.text_field(  :id, 'iLastName' ).set       business[ "last_name" ]
  @browser.select_list( :id, 'iBirthMonth' ).select business[ 'birth_month' ]
  @browser.select_list( :id, 'iBirthDay' ).select   business[ 'birth_day' ]
  @browser.select_list( :id, 'iBirthYear' ).select  business[ 'birth_year' ]
  @browser.select_list( :id, 'iGender' ).select     business[ 'gender' ]
  @browser.link( :id, 'iliveswitch' ).click

  sleep 2
  @browser.text_field( :name, 'iPwd' ).set       business[ 'password' ]
  @browser.text_field( :name, 'iRetypePwd' ).set business[ 'password' ]
  @browser.link( :id, 'iqsaswitch' ).click

  sleep 2
  @browser.select_list( :id, 'iSQ' ).set 'Name of first pet'
  # @browser.text_field( :id, 'iAltEmail' ).set    business[ 'email' ]
  @browser.text_field( :id, 'iSA' ).set          business[ 'secret_answer' ]
  @browser.select_list( :id, 'iCountry' ).select business[ 'country' ]
  @browser.text_field( :id, 'iZipCode' ).set     business[ 'zip' ]
  @browser.checkbox( :id, 'iOptinEmail' ).clear

  email_name = get_email_name( business )
  #begin
    @browser.text_field( :id, 'imembernamelive' ).set email_name
    captcha_text = solve_captcha()
    @browser.text_field( :class, 'spHipNoClear hipInputText' ).set captcha_text
   #  @browser.button( :title, 'I accept' ).click

   #  Watir::Wait::until do
   #    @browser.link( :text, 'Continue to Hotmail' ).exists? or  @browser.p( :id, 'iMembernameLiveError' ).exists?
   #    #and @browser.p( :id, 'iMembernameLiveError' ).text.include? "@hotmail.com isn't available." )
   #  end
   #  email_name = email_name + '1'
  # end until @browser.link( :text, 'Continue to Hotmail' ).exists?

  business[ 'hotmail' ] = email_name + '@hotmail.com'

  RestClient.post "#{@host}/bing/save_hotmail?auth_token=#{@key}&business_id=#{@bid}", :email => business['hotmail'], :password => business['password'], :secret_answer => business['secret_answer']
end

@browser = Watir::Browser.new
@browser.goto( 'https://signup.live.com/' )
sign_up( data )

if @chained
  ContactJob.start("Bing/CheckListing")
end

true
