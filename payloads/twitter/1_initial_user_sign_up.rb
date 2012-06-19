data = {}
data['contact_first_name'] = 'Bill'
data['contact_last_name']  = 'Snorgie'
data['email']              = 'abcx4@blazingdev.com'
data['gender']             = 'Male'
data['birth_month']        = 'Nov'
data['birth_day']          = '9'
data['birth_year']         = '1980'
data['password']           = '1zqa2xwsK'

browser = Watir::Browser.start("https://twitter.com/") # -
# browser.a(:link, "Sign up here").click # Untested
browser.text_field(:name, "user[name]").set data['contact_first_name']+' '+data['contact_last_name']
browser.text_field(:name, "user[email]").set data['email'] # -
browser.text_field(:name, "user[user_password]").set data['password']
browser.button(:class, 'btn signup-btn').click
Watir::Wait::until do
    browser.text.include? "agree to the terms below"
end
browser.button(:class, 'submit button promotional').click
