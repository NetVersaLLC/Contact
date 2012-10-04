Given /^I am a signed in user$/ do
  email = 'testing@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!
  visit new_user_session_path
  fill_in "user_email", :with=>email
  fill_in "user_password", :with=>password
  click_button "Sign In"
  page.should have_content('Signed in')
end

When /^I go to the new packages page$/ do
  visit(new_subscription_path)
end

Then /^I should see a list of packages$/ do
  page.should have_content('Packages')
end

Given /^I am on the new packages page$/ do
  visit(new_subscription_path)
  current_path.should eq(new_subscription_path)
end

When /^I fill "(.*?)" with "(.*?)"$/ do |arg1,arg2|
  fill_in  arg1, :with => arg2
end

When /^I select "(.*?)" as the state$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in Zip with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in Card Number with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I select "(.*?)" as the "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in CVV with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I click "(.*?)"$/ do |arg1|
  click_button arg1
end
