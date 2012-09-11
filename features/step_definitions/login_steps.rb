Given /^I am at login page$/ do
  visit LoginPage
end
Given /^I am logged in as (.+)$/ do |user|
  steps %Q{
    Given I am at login page
    When I login as #{user}
        }
end

When /^I login as (.+)$/ do |username|
  on(LoginPage).login_with(username, PASSWORD)
end

Then /^(.+) page should open$/ do |_|
  @browser.url.should == on(HomePage).class.url
end
Then /^I should see feedback (.+)$/ do |feedback|
  on(HomePage).feedback.should match Regexp.escape(feedback)
end
