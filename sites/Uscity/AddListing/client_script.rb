def add_listing(data)
  @browser.goto('http://uscity.net/register')
  @browser.text_field(:name => 'email').set data[ 'email' ]
  @browser.text_field(:name => 'password').set data[ 'password' ]
  @browser.text_field(:name => 'name').set data[ 'full_name' ]
  @browser.select_list(:name => 'security_ques').select data[ 'security_question' ]
  @browser.text_field(:name => 'security_ans').set data[ 'security_answer' ]
  @browser.text_field(:name => 'business_name').set data[ 'business' ]
  @browser.text_field(:name => 'web_url').set data[ 'website' ]
  @browser.text_field(:name => 'business_address').set data[ 'address' ]
  @browser.text_field(:name => 'town').set data[ 'city' ]
  @browser.select_list(:name => 'state_linkId').option(:value=> "#{data[ 'state' ]}").select
  @browser.text_field(:name => 'zip').set data[ 'zip' ]
  @browser.text_field(:name => 'daytime_phone').set data[ 'phone' ]
  @browser.text_field(:name => 'short_description').set data[ 'business_description' ]
  @browser.text_field(:name => 'category_name[]').set data[ 'category' ]
  @browser.text_field(:name=> 'category_name[]').send_keys(:down)
  @browser.send_keys(:return)
  
  #Enter Decrypted captcha string here
  enter_captcha( data )

  @confirmation_msg = 'Verification link has been sent to your email.'

  if @browser.text.include?(@confirmation_msg)
    puts "Initial registration Successful"
    RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data[ 'username' ], 'account[password]' => data['password'], 'model' => 'Uscity'
  else
    throw "Initial registration not successful"
  end
end

# Main Steps
url = 'http://uscity.net'
@browser.goto(url)

if search_business(data)
  puts "Business Already Exist"
else
  add_listing(data)
end
