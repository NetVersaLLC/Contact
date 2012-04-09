@base_url = "http://www.merchantcircle.com/"
    @driver.find_element(:id, "global_join_now").click
    @driver.find_element(:css, "img.submitButton").click
    @driver.find_element(:id, "name").clear
    @driver.find_element(:id, "name").send_keys "Argleblat Industries"
    @driver.find_element(:id, "telephone").clear
    @driver.find_element(:id, "telephone").send_keys "573 529 2536"
    @driver.find_element(:id, "address").clear
    @driver.find_element(:id, "address").send_keys "2933 Leeway Dr"
    @driver.find_element(:id, "zip").clear
    @driver.find_element(:id, "zip").send_keys "65202"
    @driver.find_element(:id, "fname").clear
    @driver.find_element(:id, "fname").send_keys "James"
    @driver.find_element(:id, "lname").clear
    @driver.find_element(:id, "lname").send_keys "Argleblat"
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys "cnzgizym@blazingdev.com"
    @driver.find_element(:id, "email2").clear
    @driver.find_element(:id, "email2").send_keys "cnzgizym@blazingdev.com"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "jgjltxis"
    @driver.find_element(:id, "offers").click
    @driver.find_element(:id, "tos_agree").click
    @driver.find_element(:name, "submit").click
    @driver.find_element(:id, "input_webUrl").clear
    @driver.find_element(:id, "input_webUrl").send_keys "http://argleblatindustries.com"
    @driver.find_element(:id, "input_desc_p").clear
    @driver.find_element(:id, "input_desc_p").send_keys "Some short business discription should go here."
    @driver.find_element(:id, "input_hours_span").clear
    @driver.find_element(:id, "input_hours_span").send_keys "9-5"
    @driver.find_element(:id, "input_paymentsAccepted_span").clear
    @driver.find_element(:id, "input_paymentsAccepted_span").send_keys "Discover, Mastercard, American Express"
    @driver.find_element(:id, "next").click
    @driver.find_element(:id, "free_button").click

#Please Confirm Your Registration
