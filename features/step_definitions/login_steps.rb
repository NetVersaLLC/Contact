Given /^I am at login page$/ do
  visit LoginPage
end

When /^I login as (.+)$/ do |username|
  on(LoginPage).login_with(username, PASSWORD)
end

Then /^I should see feedback (.+)$/ do |feedback|
  on(HomePage) do |page|
    @browser.url.should == page.class.url
    page.feedback.should match Regexp.escape(feedback)
  end
end
