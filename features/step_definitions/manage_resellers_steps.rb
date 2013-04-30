Given /I am on the sign up page/ do 
  white_label
  visit new_user_registration_path
end 

Given /I have signed in to the admin panel/ do 
  reseller 
  sign_in
  visit admin_root_path
end 

Given /My label has (\d+) credits/ do |number_of_credits|
  reseller.label.credits = number_of_credits
  reseller.label.save!
end 

And /I have a child label with (\d+) credits/ do |number_of_credits|
  child_label = FactoryGirl.build(:label, name: "example2.com") 
  child_label.credits = number_of_credits 
  child_label.parent_id = reseller.label.id 
  child_label.save!
end 

When /I fill in "([^"]*)" with "([^"]*)"/ do |field, value| 
  pending
  #fill_in field, :with => value 
end 

When /I am taken to the dashboard/ do 
  page.should have_content("Dashboard") 
end 

When /I transfer (#{CAPTURE_A_NUMBER}) credits to the child label/ do |amount|
  parent = reseller.label 
  child = parent.children.first
  Label.transfer( amount, parent, child )
end 

Then /I should see my account balance/ do 
  page.should have_content( white_label.credits - 1 ) 
end 

Then /I should see (\d+) credits for my label/ do |credits| 
  page.should have_content( credits ) 
end 

Then /I should see (\d+) credits for my child label/ do |credits| 
  page.should have_content( credits ) 
end 

Then /I should see "Welcome Reseller"/ do 
end 

Then /My label should have (#{CAPTURE_A_NUMBER}) credits/ do |amount| 
  reseller.label.credits.should eq(amount) 
end 

And /The child should have (#{CAPTURE_A_NUMBER}) credits/ do |amount| 
  reseller.label.children.first.credits.should eq(amount) 
end 
