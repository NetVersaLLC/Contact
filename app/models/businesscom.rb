class Businesscom < ClientData
  attr_accessible :business_id, :email, :username
  virtual_attr_accessor :password

  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def has_categories? 
    false
  end 

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end
end
