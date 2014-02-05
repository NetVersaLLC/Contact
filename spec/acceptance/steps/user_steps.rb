### UTILITY METHODS ###

def create_package_coupon
   FactoryGirl.create(:label, :domain => 'test.host', :label_domain => 'test.host')
   @package = FactoryGirl.create(:package)
   @coupon = FactoryGirl.create(:coupon)
end



#### GIVEN ####


step "I have coupon code and package with me" do 
  create_package_coupon
end



### WHEN ####
step "I sign up with/as :email" do |email|
   visit '/users/sign_up?package_id=1'
   fill_in 'coupon', :with => @coupon.name
   fill_in "Email", :with => email 
   fill_in "user_password", :with => '12345678'
   fill_in "user_password_confirmation", :with => '12345678'
   fill_in "creditcard[name]", :with => 'testuser'
   fill_in "card_number", :with => "4007000000027"
   select('06', :from => 'card_month')
   select('2017', :from => 'card_year')
   fill_in 'cvv', :with => 100
   find('#tos', visible: false).set(true)
   click_button "Place Order"
 end 


 #Then

 step "I should see sign up message" do 
   page.should have_content "Welcome! You have signed up successfully"
 end

