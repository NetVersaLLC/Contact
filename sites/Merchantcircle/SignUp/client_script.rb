@browser.goto("http://www.merchantcircle.com/signup?utm_medium=signup")
@browser.text_field(:id, "name").set data['name']
@browser.text_field(:id, "telephone").set data['phone']
@browser.text_field(:id, "address").set data['address']
@browser.text_field(:id, "zip").set data['zip']
@browser.text_field(:id, "fname").set data['first_name']
@browser.text_field(:id, "lname").set data['last_name']
@browser.text_field(:id, "email").set data['email']
@browser.text_field(:id, "email2").set data['email']
@browser.text_field(:id, "password").set data['password']
@browser.checkbox(:id, "offers").click
@browser.checkbox(:id, "tos_agree").click
@browser.button(:value, "Submit").click

RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => data['email'], 'account[password]' => data['password'], 'model' => 'Merchantcircle'


#@browser.button(:value, "Finished").click
@browser.link(:text, "No, Thanks").click
@browser.link(:text, "No, thanks").click
@browser.link(:text, "Continue").click
@browser.link(:href, "http://www.merchantcircle.com/merchant/edit").click
@browser.text_field( :id, "description").set data[ 'description' ]
@browser.text_field( :id, "fax").set data[ 'fax' ]
@browser.text_field( :id, "tollfree").set data[ 'tollfree' ]
@browser.text_field( :id, "url").set data[ 'website' ]
@browser.text_field( :id, "tags").set data[ 'keywords']
@browser.radio( :id, "custom_hours").click
@browser.select( :name, "NewHours-0.openingStart").select data[ 'monOpen' ]
@browser.select( :name, "NewHours-0.closingEnd").select data[ 'monClose' ]
@browser.select( :name, "NewHours-1.openingStart").select data[ 'tuesOpen' ]
@browser.select( :name, "NewHours-1.closingEnd").select data[ 'tuesClose' ]
@browser.select( :name, "NewHours-2.openingStart").select data[ 'wedOpen' ]
@browser.select( :name, "NewHours-2.closingEnd").select data[ 'wedClose' ]
@browser.select( :name, "NewHours-3.openingStart").select data[ 'thurOpen' ]
@browser.select( :name, "NewHours-3.closingEnd").select data[ 'thurClose' ]
@browser.select( :name, "NewHours-4.openingStart").select data[ 'fridOpen' ]
@browser.select( :name, "NewHours-4.closingEnd").select data[ 'fridClose' ]
@browser.select( :name, "NewHours-5.openingStart").select data[ 'satOpen' ]
@browser.select( :name, "NewHours-5.closingEnd").select data[ 'satClose' ]
@browser.select( :name, "NewHours-6.openingStart").select data[ 'sunOpen' ]
@browser.select( :name, "NewHours-6.closingEnd").select data[ 'sunClose' ]
@browser.button( :name, "updateListing").click
