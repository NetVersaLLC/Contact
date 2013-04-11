Given /I have signed in as [a]n? (admin|reseller|user)/ do |role|
  label = Label.new(name: 'towncenter', login: 'login', password: 'pswd', domain: 'domain' )
  label.logo_file_name = "nothing" 
  label.save!

  EMAIL = 'test@contact.dev' 
  PASSWORD = '123456' 

  u = User.new(email: EMAIL, password: PASSWORD) 
  u.access_level = User.send role 
  u.label = label
  u.save! 

  visit new_user_session_path 
  fill_in 'user_email', with: EMAIL 
  fill_in 'user_password', with: PASSWORD 
  click_button 'Sign In' 

end 

Given /I am on the edit business page/ do 
  page.has_text? 'Business Details' 
end 

