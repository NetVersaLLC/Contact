Given /^I am an anonymous site visitor$/ do
  visit("/")
  page.should have_content("Sign In")
end

When /^I click "Sign Up"$/ do
  click_link "Sign Up"
end

Then /^I am taken to the sign up page\.$/ do
  page.should have_content('Password confirmation')
end

Given /^I am on the sign up page$/ do
  visit("/users/sign_up")
end

When /^I fill in "Email" with "(.*?)"$/ do |email|
  fill_in("Email", :with => email)
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
