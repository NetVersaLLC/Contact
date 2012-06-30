browser = Watir::Browser.start("https://www.facebook.com/") # -
browser.a(:link, "Sign up here").click # Untested
browser.text_field(:name, "firstname").set business['first_name']
browser.text_field(:name, "lastname").set business['last_name']
browser.text_field(:name, "email").set business['email'] # - 
browser.select_list(:id, "gender").select business['gender'] # from options %w{Male Female}
browser.select_list(:id, "month").select business['birth_month'] # from options %w{Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec}
browser.select_list(:id, "day").select business['birth_day']
browser.select_list(:id, "year").select business['birth_year']
browser.text_field(:name, "pass").set business['password']
browser.button(:name, "submit").click
