def sign_in 
  visit new_user_session_path 

  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button 'user_submit_action' 
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

