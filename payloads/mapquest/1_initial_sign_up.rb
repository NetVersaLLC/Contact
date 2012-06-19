data = {}
data['contact_first_name'] = 'Bill'
data['contact_last_name']  = 'Snorgie'
data['email']              = 'abcx4@blazingdev.com'
data['phone']              = '573-529-2328'
data['gender']             = 'Male'
data['birth_month']        = 'Nov'
data['birth_day']          = '9'
data['birth_year']         = '1980'
data['password']           = '1zqa2xwsK'

browser = Watir::Browser.start("https://listings.mapquest.com/apps/listing")
browser.text_field(:name => "firstName").set data['contact_first_name']
browser.text_field(:name => "lastName").set data['contact_last_name']
browser.text_field(:name => "phone").set data['phone']
browser.text_field(:name => "email").set data['email']
browser.a(:class => 'createaccount btn-var submit').click
Watir::Wait::until do
    browser.text.include? "Confirmation email sent to"
end
