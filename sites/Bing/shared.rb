def solve_captcha
  puts 'Solve captcha'

  image = "#{Dir.tmpdir}/bing_captcha.png"
  @browser.image( :src, /HIPImage/ ).save( image )

  CAPTCHA.solve file_path, :manual
end

def sign_in( business )
  @browser.goto( 'https://login.live.com/' )
  @browser.text_field( :name, 'login' ).set  business[ 'hotmail' ]
  @browser.text_field( :name, 'passwd' ).set business[ 'password' ]
  # @browser.checkbox( :name, 'KMSI' ).set
  @browser.button( :name, 'SI' ).click
end

def search_for_business( business )
  @browser.goto( 'http://www.bing.com/businessportal/' )
  puts 'Search for the ' + business[ 'name' ] + ' business at ' + business[ 'city' ] + ' city'
  @browser.link( :text , 'Get Started Now!' ).click

  sleep 2 # seems that div's are not loaded quickly simetimes
  @browser.div( :class , 'LiveUI_Area_Find___Business' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'name' ]
  @browser.div( :class , 'LiveUI_Area_Find___City' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'city' ]
  @browser.div( :class , 'LiveUI_Area_Find___State' ).text_field( :class, 'LiveUI_Field_Input' ).set business[ 'state_short' ]
  @browser.div( :class , 'LiveUI_Area_Search_Button LiveUI_Short_Button_Medium' ).click
end
