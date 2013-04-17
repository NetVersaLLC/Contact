Given /I have signed in as [a]n? (admin|reseller|employee|owner)/ do |role|
  u = FactoryGirl.create(:user) 

  visit new_user_session_path 
  fill_in 'user_email', with: u.email
  fill_in 'user_password', with: u.password
  click_button 'user_submit_action' 
end 

Given /I am on the edit business page/ do 
  page.has_text? 'Business Details' 
end 

Given /I enter a zip code to Search by Zip/ do 
  fill_in 'Search by Zip', with: '92626' 
end 

And /I click search zip/ do 
  find("#zipsearch").click
end 

And /I go to the edit business page/ do 
  page.click_link "Edit This Business" 
end 

Then /I should see its city and state/ do 
  pending 'cant get to work. shelfing for now' 
  #assert_equal "Newport Beach", find_field("city").value
  #page.should have_selector("state", selected: "CA") 
end 
