Given /I have signed in as [a]n? (admin|reseller|employee|owner)/ do |role|
  @user = FactoryGirl.create(:user) 

  visit new_user_session_path 
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  click_button 'user_submit_action' 
end 

Given /I am on the edit business page/ do 
  page.has_text? 'Business Details' 
end 

Given /I enter a "([^"]*)" to Search by Zip/ do |zip|
  fill_in 'Search by Zip', with: zip
end 

Given /I have entered my city and state/ do 
  location = FactoryGirl.build(:location) 
  fill_in 'city', with: location.city 
  page.find("#state").set( location.state ) 
end 

When /I enter "([^"]*)" in Company Name/ do |company_name| 
  fill_in 'company_name', with: company_name 
end 

And /I click Company Name Search/ do 
  find("#search").click
  find("#business_results") # wait for results 
end 

Then /I should see "([^"]*)"/ do |company_name| 
  find("td", :text => company_name).text().should eq(company_name) 
end 


And /I click search zip/ do 
  find("#zipsearch").click
  # because the html elements already exist for city and state, 
  # there isnt a way to use find() 
  # to wait until the ajax completes.  
  sleep(1)
end 

And /I go to the edit business page/ do 
  page.click_link "Edit This Business" 
end 

Then /I should see its "([^"]*)" and "([^"]*)"/ do |city,state|
  find_field("state").value.should eq(state)
  find_field("city").value.should eq(city) 

  #assert_equal @location.city, find_field("city").value 
  #assert_equal @location.state, find_field("state").value 
end 


