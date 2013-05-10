CAPTURE_A_NUMBER = Transform /^\d+$/ do |number| 
  number.to_i 
end 

module ContactWorld
  # Actors 
  # 
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
    @user ||= FactoryGirl.create(:user, :access_level => User.reseller) 
  end 
  
  def white_label 
    @white_label ||= FactoryGirl.create(:label)
  end 
end 

World(ContactWorld) 
