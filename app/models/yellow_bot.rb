class YellowBot < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password

  def self.get_data_for_signup(business)
    data = {}
    phone_number         = business.contact_phone # 555-555-1212
    data['phone_area']   = phone_number.split(/-/)[0]
    data['phone_prefix'] = phone_number.split(/-/)[1]
    data['phone_suffix'] = phone_number.split(/-/)[2]
    data['username']     = business.username
    data['email']        = business.email
    data['password']     = YellowBot.make_password
    data
  end

  def self.make_password
  end
end
