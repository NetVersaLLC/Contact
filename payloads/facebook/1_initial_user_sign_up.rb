data = {}
data['contact_first_name'] = 'Bill'
data['contact_last_name']  = 'Snorgie'
data['email']              = 'abcx4@blazingdev.com'
data['gender']             = 'Male'
data['birth_month']        = 'Nov'
data['birth_day']          = '9'
data['birth_year']         = '1980'
data['password']           = '1zqa2xwsK'

browser = Watir::Browser.start("https://www.facebook.com/") # -
# browser.a(:link, "Sign up here").click # Untested
browser.text_field(:name, "firstname").set data['contact_first_name']
browser.text_field(:name, "lastname").set data['contact_last_name']
browser.text_field(:name, "reg_email__").set data['email'] # -
browser.text_field(:name, "reg_email_confirmation__").set data['email'] # -
browser.text_field(:name, "reg_passwd__").set data['password']
browser.select_list(:id, "sex").select data['gender'] # from options %w{Male Female}
browser.select_list(:id, "birthday_month").select data['birth_month'] # from options %w{Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec}
browser.select_list(:id, "birthday_day").select data['birth_day']
browser.select_list(:id, "birthday_year").select data['birth_year']
browser.button(:value, "Sign Up").click
sleep 1
form = browser.form(:id, 'nux_wizard_page_form')
form.submit
sleep 1
browser.button(:value, "Skip").click
sleep 1
browser.button(:value, "Skip").click
sleep 1
browser.button(:value, "Skip").click
