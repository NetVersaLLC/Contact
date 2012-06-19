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
data['short_description']  = 'Great little business that plumbs.'
data['hours']              = '9 to 5'
data['payment_methods']    = 'Visa'

browser = Watir::Browser.start("http://www.merchantcircle.com/")
browser.a(:id => "global_join_now").click
browser.a(:class =>"submitButton").click
browser.text_field(:id, "name").set data['business_name']
browser.text_field(:id, "telephone").set data['phone']
browser.text_field(:id, "address").set data['address']
browser.text_field(:id, "zip").set data['zip']
browser.text_field(:id, "fname").set data['contact_first_name']
browser.text_field(:id, "lname").set data['contact_last_name']
browser.text_field(:id, "email").set data['email']
browser.text_field(:id, "email2").set data['email']
browser.text_field(:id, "password").set data['password']
browser.a(:id, "offers").click
browser.a(:id, "tos_agree").click
browser.button(:name, "submit").click
browser.text_field(:id, "input_webUrl").set data['website']
browser.text_field(:id, "input_desc_p").set data['short_description']
browser.text_field(:id, "input_hours_span").set data['hours']
browser.text_field(:id, "input_paymentsAccepted_span").set data['payment_methods']
browser.a(:id, "next").click
browser.a(:id, "free_button").click
browser.text.include? 'Please Confirm Your Registration'
