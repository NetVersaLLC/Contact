class Aol < ClientData
  attr_accessible       :username
  virtual_attr_accessor :password, :secret_answer

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end
  def self.make_secret_answer
    Faker::Address.city
  end
end
