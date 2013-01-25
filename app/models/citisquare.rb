class Citisquare < ClientData
  attr_accessible :email, :citisquare_category_id
  virtual_attr_accessor :password
  belongs_to            :citisquare_category

  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end
end
