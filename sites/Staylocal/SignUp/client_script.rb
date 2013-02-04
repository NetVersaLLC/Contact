def add_new_business(data)
  @browser.text_field(:name => 'name').set data[ 'username' ]
  @browser.text_field(:name => 'mail').set data[ 'email' ]
  @browser.text_field(:name => 'pass[pass1]').set data[ 'password' ]
  @browser.text_field(:name => 'pass[pass2]').set data[ 'password' ]
  @browser.text_field(:name => 'title').set data[ 'business' ]
  @browser.text_field(:name => /street/).set data[ 'address' ]
  @browser.text_field(:name => /city/).set data[ 'city' ]
  @browser.text_field(:id => /province/).set data[ 'state' ]
  @browser.text_field(:id => /province/).send_keys :tab
  @browser.text_field(:name => /postal_code/).set data[ 'zip' ]
  @browser.text_field(:name => /phone/).set data[ 'phone' ]
  @browser.text_field(:name => /business_owner/).set data[ 'full_name' ]
  @browser.text_field(:name => /business_owner_email/).set data[ 'email' ]
  @browser.text_field(:name => /description/).set data[ 'business_description' ]
  @browser.text_field(:name => /keywords/).set data[ 'keywords' ]
  @browser.select_list(:name => /edit-taxonomy-4/).select data[ 'category' ]
  @browser.select_list(:name => /edit-taxonomy-2/).select data[ 'parish' ]
  @browser.text_field(:name => /website/).set data[ 'website' ]
  @browser.text_field(:name => /operating_hours/).set data[ 'operating_hours' ]
  
  #Enter Captcha Code
  # @browser.text_field(:name => 'recaptcha_response_field').set captcha_textcha
  @browser.button(:value => 'Save').click
  
  #Check for error
  @error_msg = @browser.div(:class => 'messages error')
  if @error_msg.exist?
    puts "Showing error message saying #{@error_msg.text}"
  end

  #Check for confirmation
  @success_text ="A validation e-mail has been sent to your e-mail address. In order to gain full access to the site, you will need to follow the instructions in that message."
  
  if @browser.span(:id => /registered_infotext/).text.include?(@success_text)
    puts "Initial Business registration is successful"
    RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data[ 'username' ], 'account[password]' => data['password'], 'model' => 'Staylocal'
  else
    throw "Initial Business registration is Unsuccessful"
  end
end

#~ #Main Steps
#~ # Launch browser
@url = 'https://www.staylocal.org/node/add/business-listing'
@browser.goto(@url)

add_new_business(data)
