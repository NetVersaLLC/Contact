class Google < ClientData
  attr_accessible       :email
  virtual_attr_accessor :password
  belongs_to            :google_category

  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true,
            :format => { :with => /^\w\w\w\w\w\w\w\w+$/i }

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 8)
  end

  def self.make_email_names(business)
    name = business.business_name.gsub(/\s+|[^A-Za-z0-9]+/, '')
    choices = [name]
    choices.push name + business.zip
    choices.push name + '1'
    choices.push name + business.city.gsub(/\s+|[^A-Za-z0-9]+/, '')
    choices.push name + business.year_founded.to_s
    choices.each do |choice|
      choice.downcase! if (rand()*10) > 5
    end
    choices.sort_by { rand }
  end
end
