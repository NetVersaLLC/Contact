class AngiesList < ClientData
  attr_accessible :email, :angies_list_category_id
  virtual_attr_accessor :password
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
 belongs_to            :angies_list_category
  
  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 8).gsub("_","").gsub("-","")
  end
end