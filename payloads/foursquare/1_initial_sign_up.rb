data = {}
data['business_name']      = 'Shogun Plumbing'
data['contact_first_name'] = 'Bill'
data['contact_last_name']  = 'Snorgie'
data['email']              = 'abcx4@blazingdev.com'
data['gender']             = 'Male'
data['address']            = '2934 Leeway Dr'
data['address2']           = ''
data['birth_month']        = 'Nov'
data['phone']              = '573-529-2374'
data['birth_day']          = '9'
data['zip']                = '65202'
data['city']               = 'Columbia'
data['state']              = 'MO'
data['birth_year']         = '1980'
data['password']           = '1zqa2xwsK'
data['website']            = 'http://blazingsuana.com'
data['yelp_category']      = ['Pets', 'Pet Stores']


browser = Watir::Browser.start("https://foursquare.com/search?q=saigon&near=columbia%2C+mo")
browser.text_field(:id, "q").set data['business_name']
browser.text_field(:id, "near").set data['city']+', '+data['state']
browser.a(:class, "p.translate > input.greenButton.translate").click
browser.a(:text, data['business_name']).click
browser.a(:text, "Claim here").click
browser.a(:text, "Sign up for foursquare").click
browser.a(:text, "Sign up with Email").click
browser.text_field(:id, "firstname").set data['contact_first_name']
browser.text_field(:id, "lastname").set data['contact_last_name']
browser.text_field(:class, "#emailWrapper > span.input-holder > span.input-default").click
browser.text_field(:id, "userEmail").set data['email']
browser.text_field(:name, "F221050266016CQERJO").set data['password']
browser.text_field(:id, "userPhone").set data['phone']
browser.text_field(:id, "userLocation").set data['city']
browser.select_list(:name, "F2210502660211XIFK5").select data['birth_month']
browser.file_field(:name, "F221050266022QSTXN5").set data.profile_image
browser.button(:name, "F221050466023UV1TUH").click
browser.a(:id, "skip").click
