class Byzlyst < ClientData
attr_accessible :username, :byzlyst_category_id
  virtual_attr_accessor :password
  belongs_to            :byzlyst_category
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end