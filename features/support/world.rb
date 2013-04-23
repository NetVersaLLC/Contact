module Actors 
  # default to owner 
  # By settign an actor this way, then we can reuse steps by using the user method. 
  # I am a reseller -> reseller 
  # sign in with user.email/user.password 
  def user 
    @user ||= owner 
  end 
  
  def not_a_user 
    @user ||= FactoryGirl.build(:user, :email => "notfound@anywhere.dev") 
  end 

  def owner 
    @user ||=  FactoryGirl.create(:user) 
  end 

  def reseller 
    @user ||= Factory.create(:user, :access_level => User.reseller) 
  end 
end 

World(Actors) 
