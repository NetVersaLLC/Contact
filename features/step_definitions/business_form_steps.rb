Given /I have signed in as an owner/ do 
  owner 
  sign_in # from sign_in_steps.rb 
end 

Given /I have entered my city and state/ do 
  location = FactoryGirl.create(:location) 

  fill_in 'city', with: location.city 
  page.find("#state").set( location.state ) 
end 

And /I go to the edit business page/ do 
  page.click_link "Edit This Business" 
  page.has_text? 'Business Details' 
end 

And /I click Company Name Search/ do 
  find("#search").click
  find("#business_results") # wait for results 
end 

When /I first arrive on the page/ do 
end 

When /I search with "(\d{5})"/ do |zip|
  fill_in 'Search by Zip', :with => zip 
  find("#zipsearch").click
  # because the html elements already exist for city and state, 
  # there isnt a way to use find() 
  # to wait until the ajax completes.  
  sleep(1)
end 

When /I search for a company like "([^"]*)"/ do |company_name| 
  fill_in 'company_name', with: company_name 
  #find("#company_search").click 
  click_on('company_search')
end 

Then /I should see a company named "([^"]*)"/ do |company_name| 
  find("td", :text => company_name).text().should eq(company_name) 
end 

Then /I should see "([^"]*)" and "(.{2})"/ do |city, state|
  find_field("state").value.should eq(state)
  find_field("city").value.should eq(city) 
end 


