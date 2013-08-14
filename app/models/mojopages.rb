class Mojopages < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to            :mojopages_category


  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end



end
