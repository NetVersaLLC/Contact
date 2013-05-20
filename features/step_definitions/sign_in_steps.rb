def sign_in 
  visit new_user_session_path 

  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button 'user_submit_action' 
end 

def sign_up
  visit new_user_registration_path + "?package_id=#{package.id}" 

  c = FactoryGirl.create(:coupon, :code => 'netversa', :name => 'netversa', :label => white_label) 
  fill_in "coupon", with: c.name 
  click_button 'Add' 

  find('#new_user').should have_content('netversa') 

  u = FactoryGirl.build(:user) 

  fill_in 'email', with: u.email 
  fill_in 'password', with: u.password 
  fill_in 'password_confirmation', with: u.password 
  check 'user_tos' 

  click_button 'Place Order' 
end 

Given /I am a user/ do 
  user 
end 

Given /I am not a user/ do 
  not_a_user 
end 

And /I forgot my password/ do 
  user.password = "i forgot" 
end 

When /I sign in/ do 
  sign_in
end 

Then /I should be signed in/ do 
  page.should have_content("Sign Out") 
end 

Then /I should see a link to sign up/ do 
  page.should have_content("not registered") 
  page.should have_link("Sign up") 
end 

Then /I should see a link to reset it/ do 
  page.should have_content("Account registered") 
  page.should have_link("Forgot") 
end 

