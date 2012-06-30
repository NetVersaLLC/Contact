browser = Watir::Browser.start("http://www.merchantcircle.com/")
browser.a(:id => "global_join_now").click
browser.a(:class =>"submitButton").click
browser.text_field(:id, "name").set business['name']
browser.text_field(:id, "telephone").set business['phone']
browser.text_field(:id, "address").set business['address']
browser.text_field(:id, "zip").set business['zip']
browser.text_field(:id, "fname").set business['first_name']
browser.text_field(:id, "lname").set business['last_name']
browser.text_field(:id, "email").set business['email']
browser.text_field(:id, "email2").set business['email']
browser.text_field(:id, "password").set business['password']
browser.a(:id, "offers").click
browser.a(:id, "tos_agree").click
browser.button(:name, "submit").click
browser.text_field(:id, "input_webUrl").set business['website']
browser.text_field(:id, "input_desc_p").set business['short_description']
browser.text_field(:id, "input_hours_span").set business['hours']
browser.text_field(:id, "input_paymentsAccepted_span").set business['payment_methods']
browser.a(:id, "next").click
browser.a(:id, "free_button").click
browser.text.include? 'Please Confirm Your Registration'
