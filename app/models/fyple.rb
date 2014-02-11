class Fyple < ClientData
  belongs_to :fyple_category
  attr_accessible :email, :status
  virtual_attr_accessor :password
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

end 

