def solve_captcha
  puts 'Solve captcha'

  image = "#{Dir.tmpdir}/bing_captcha.png"
  obj = @browser.image( :xpath, "//div/table/tbody/tr/td/img[1]" )
  puts "obj: #{obj.name}"
  puts "spect: #{obj.inspect}"
  puts "width: #{obj.width}"

  CAPTCHA.solve obj, :manual
  print "Solve captcha: "
  gets
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

def goto_listing( business )
  @browser.goto( 'http://www.bing.com/businessportal/' )
  @browser.link( :text , 'Sign In Here').click

  Watir::Wait::until do
    @browser.div( :text, 'LISTINGS' ).exists?
  end

  @browser.div( :class, 'LiveUI_Area_Items_Repeating' ).div( :text, business['name'] ).click
end
