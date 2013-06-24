class Google < ClientData
  attr_accessible       :email,:cookies
  virtual_attr_accessor :password
  belongs_to            :google_category

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
