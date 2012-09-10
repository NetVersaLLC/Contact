class LoginPage
  include PageObject

  def self.url
    "#{BASE_URL}users/sign_in"
  end
  page_url url

  button(:login, id: "user_submit")
  text_field(:password, id: "user_password")
  text_field(:username, id: "user_email")

  def login_with(username, password)
    self.username = username
    self.password = password
    login
  end
end
