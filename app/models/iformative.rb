class Iformative < ClientData 
  attr_accessible :email, :status, :listing_url, :username
  virtual_attr_accessor :password
end
