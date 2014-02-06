### UTILITY METHODS ###


#### GIVEN ####

# step "I am on the sign up page" do
#   visit '/users/sign_up'
#   page.should have_css("user_email")
# end

step "I have label with me" do 
   # l = Label.create(:name=>'contact_test', :domain=>'localhost')
   # l.save(:validate => false)
   FactoryGirl.create(:label, :domain => 'test.host', :label_domain => 'test.host')
   @package = FactoryGirl.create(:package)
   @coupon = FactoryGirl.create(:coupon)
end

### WHEN ####
step "I sign up with/as :email" do |email|
   #initiate_label
   visit '/users/sign_up?package_id=1'
   #binding.pry
   fill_in 'coupon', :with => @coupon.name
   fill_in "Email", :with => email 
   fill_in "user_password", :with => '12345678'
   fill_in "user_password_confirmation", :with => '12345678'
   fill_in "creditcard[name]", :with => 'testuser'
   #fill_in "creditcard_type", :with => "visa"
   #find('#creditcard_type', visible: false).set("visa")
   fill_in "card_number", :with => "4007000000027"
   select('06', :from => 'card_month')
   select('2017', :from => 'card_year')
   fill_in 'cvv', :with => 100
   find('#tos', visible: false).set(true)

   #check(find("input[type='checkbox']")).set(true)
   #check("tos #tos").
   #find('#tos', visible: false).set(true)
   #check('tos')
   #find(:css, "tos").set(true)
   click_button "Place Order"
   #binding.pry

 end 


  # Parameters: {"utf8"=>"✓", "authenticity_token"=>"ws4Du/FXWudwf7iXmGjP1U15Klwd/sqJHRtJeUezvk4=", "user"=>{"callcenter"=>"false", "referrer_code"=>"", "email"=>"mail@google.com", "password"=>"[FILTERED]",
  #  "password_confirmation"=>"[FILTERED]"}, "package_id"=>"1", "subtotal"=>"449", "total"=>"449", 
  #  "amount_total"=>"49", "coupon"=>"NETVERSA", "creditcard"=>{"name"=>"testuser", "brand"=>"american_express",
  #   "number"=>"3400 000000 00", "month"=>"06", "year"=>"2017", "verification_value"=>"100"}, "tos"=>"on"}



 #then

 step "I should be signed in" do 
   #current_path.should == root_path
   page.should have_content "Welcome! You have signed up successfully"
 end

 
