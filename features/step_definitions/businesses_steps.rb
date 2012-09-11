When /^I save changes$/ do
  on(HomePage).save_changes
end

Then /^Business name element should have error (.+)$/ do |error|
  on(HomePage).business_name_error_element.text.should == error
end
