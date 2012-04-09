browser = Watir::Browser.start("https://foursquare.com/search?q=saigon&near=columbia%2C+mo")
browser.text_field(:id, "q").set business['name']
browser.text_field(:id, "near").set business['city']+', '+business['state']
browser.a(:class, "p.translate > input.greenButton.translate").click
browser.a(:text, "Saigon Bistro").click
browser.a(:text, "Claim here").click
browser.a(:text, "Sign up for foursquare").click
browser.a(:text, "Sign up with Email").click
browser.text_field(:id, "firstname").set business['first_name']
browser.text_field(:id, "lastname").set business['last_name']
browser.text_field(:class, "#emailWrapper > span.input-holder > span.input-default").click
browser.text_field(:id, "userEmail").set business['email']
browser.text_field(:name, "F221050266016CQERJO").set business['password']
browser.text_field(:id, "userPhone").set business['phone']
browser.text_field(:id, "userLocation").set business['city']
browser.select_list(:name, "F2210502660211XIFK5").select business['birth_month']
browser.file_field(:name, "F221050266022QSTXN5").set business.profile_image
browser.button(:name, "F221050466023UV1TUH").click
browser.a(:id, "skip").click
