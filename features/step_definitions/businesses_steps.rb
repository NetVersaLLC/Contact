When /^I save changes$/ do
  on(HomePage).save_changes
end

Then /^(.+) should be (.+)$/ do |element_name, value|
  element = element_name.downcase.gsub(" ", "_")
  on(HomePage).send(element).should == value
end
Then /^(.+) should have error (.+)$/ do |element, error|
  on(HomePage).error(element).should == error
end
When /^I enter (.+) in (.+)$/ do |data, element|
  on(HomePage).enter_data(data, element)
end
