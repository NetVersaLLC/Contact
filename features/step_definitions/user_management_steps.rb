Given /^I am an anonymous site visitor$/ do
  visit("/")
  page.should have_content("Sign In")
end

When /^I click "Sign Up" in upper right$/ do
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

And /^I fill in "Password" with "(.*?)"$/ do |pass|
  fill_in("Password", :with => pass)
end

And /^I fill in "Password Confirmation" with "(.*?)"$/ do |pass|
  fill_in(:password_confirmation, :with => pass)
end

And /^I click "Sign Up"$/ do
  click_link(:user_submit_action)
end

Then /^I should see "Packages"$/ do
  page.should have_content('Packages')
end
