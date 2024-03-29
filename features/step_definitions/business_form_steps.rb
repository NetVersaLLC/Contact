def sign_in_as_a_business_owner 
  owner 
  business
  sign_in # from sign_in_steps.rb 
end 
def goto_business_form 
  page.click_link "Edit This Business" 
  page.has_text? 'Business Details' 
end 
def enter_my_city_and_state 
  location = FactoryGirl.create(:location) 

  fill_in 'city', with: location.city 
  page.find("#state").set( location.state ) 
end 

Given /I am on the edit business page/ do 
  sign_in_as_a_business_owner
  goto_business_form
end 

Given /I have filled out a complete business profile/ do 
  sign_in_as_a_business_owner
  goto_business_form
end 

Given /I have signed in as an owner/ do 
  sign_in_as_a_business_owner
end 

Given /^I have signed up as an owner$/ do 
  sign_up
end 

Given /I have entered my city and state/ do 
  enter_my_city_and_state
end 

Given /I have performed an autocomplete search and have results/ do 
  sign_in_as_a_business_owner
  goto_business_form
  enter_my_city_and_state
  
  fill_in 'company_name', with: 'Kaiten'
  click_on('company_search')
  find("td", :text => 'Kaisen Kaiten')
end 

And /I change to a different field/ do 
  page.first(:css, 'input').click
end 

And /I go to the edit business page/ do 
  goto_business_form
end 

And /I click Company Name Search/ do 
  find("#search").click
  find("#business_results") # wait for results 
end 

And /"([^"]*)" should be highlighted red/ do |field_name| 
  page.should have_css("#business_" + field_name.parameterize.underscore + ".error") 
end 

And /I sign out and sign back in/ do 
   Capybara.reset_sessions!
  #click_link 'Sign Out' 
  sign_in_as_a_business_owner 
end 

When /I click on "([^"]*)"/ do |link| 
  click_on link 
end 

When /I select an image to upload/ do 
  attach_file("file", Rails.root.join('features','uploads','test_image.jpg'), :visible => false) 
end 

When /I click "Select" next to "([^"]*)"/ do |company_name| 
  find("input[data-select-for='#{company_name}']").click
end 

When /I enter "([^"]*)" into the "([^"]*)" field/ do |data, field| 
  fill_in field, :with => data 
end 

When /I first arrive on the page/ do 
  # do nothing 
end 

When /I search with "(\d{5})"/ do |zip|
  fill_in 'Search by Zip', :with => zip 
  find("#zipsearch").click
end 

When /I search for a company like "([^"]*)"/ do |company_name| 
  fill_in 'company_name', with: company_name 
  click_on('company_search')
end 

Then /I should be on the business dashboard page/ do 
  current_path.should match(/^\/businesses\/\d+/) 
end 

Then /I should see a company named "([^"]*)"/ do |company_name| 
  find("td", :text => company_name)
end 

Then /I should see "([^"]*)" in "([^"]*)"$/ do |value, field_name|
  page.has_field?("#business_" + field_name.parameterize.underscore, with: value) 
end 

Then /I should see "([^"]*)" and "(.{2})"$/ do |city, state|
  page.has_field?("#city", with: city) 
  find_field("state").value.should eq(state)
end 

Then /I should see error "([^"]*)" next to "([^"]*)"$/ do |message, label| 
  find(".error-inline").should have_content(message) 
  find("div.error").should have_content(label)
  page.should have_css("div.error") 
end 

Then /I should see the uploaded image/ do 
  page.should have_css("div.thumbnail") 
end 

Then /I should see "([^"]*)"$/ do |text| 
  page.should have_content(text, :visibile => true ) 
end 

Then /^I should see errors$/ do 
  page.should have_css('div.error') 
end 

Then /I should still be on the "([^"]*)" tab/ do |tab| 
  find("li.active").should have_content(tab)
end 

