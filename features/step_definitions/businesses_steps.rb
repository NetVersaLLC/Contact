When /^I save changes$/ do
  on(HomePage).save_changes
end

Then /^(.+) should have error (.+)$/ do |element, error|
  on(HomePage).error(element).should == error
end
When /^I enter (.+) in (.+)$/ do |data, element|
  on(HomePage).enter_data(data, element)
end
