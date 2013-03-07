def add_listing(data)
  @browser.goto('http://www.businessdb.com/sign-up')
  @browser.text_field(:name => 'password_again').set data[ 'password' ]
  @browser.text_field(:name => 'password').set data[ 'password' ]
  @browser.text_field(:name => 'company_name').set data[ 'business' ]
  @browser.select_list(:name => 'country_id').select data[ 'country' ]
  @browser.text_field(:name => 'email').set data[ 'email' ]
  @browser.checkbox(:name=> 'agreement').set
  @browser.link(:text=>'Sign Up FREE').click
  @browser.text_field(:name => 'name_surname').set data[ 'full_name' ]
  @browser.text_field(:name => 'www').set data[ 'website' ]
  @browser.text_field(:name => 'about').set data[ 'business_description' ]
  @browser.text_field(:name => 'address').set data[ 'address' ]
  @browser.text_field(:id => 'company_phone').set data[ 'phone' ]
  @browser.text_field(:id => 'company_fax').set data[ 'fax' ]
  @browser.select_list(:name => 'city_id').select data[ 'city' ]
  @browser.select_list(:name => 'category_id').select data[ 'category' ]
  @browser.link(:text=> 'Finish').click

  @confirmation_msg = 'Our premium service is launching soon!'

  if @browser.text.include?(@confirmation_msg)
    puts "Initial registration Successful"
    RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data[ 'username' ], 'account[password]' => data['password'], 'model' => 'Businessdb'
  else
    throw "Initial registration not successful"
  end
end

# Main Steps
# Launch url
url = 'http://www.businessdb.com'
@browser.goto(url)

if search_business(data)
  puts "Business Already Exist"
else
  add_listing(data)
end

