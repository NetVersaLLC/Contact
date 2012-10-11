def sign_in(business)
  @browser = Watir::Browser.start 'https://login.yahoo.com/'
  @browser.text_field(:id, 'username').set business['email']
  @browser.text_field(:id, 'passwd').set business['password']
  @browser.button(:id, '.save').click
end

