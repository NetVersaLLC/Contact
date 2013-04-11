class Yahoo < ClientData
  attr_accessible       :email, :yahoo_category_id
  virtual_attr_accessor :password, :secret1, :secret2
  belongs_to            :yahoo_category


  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end
  def self.make_secret_answer1
    Faker::Name.first_name
  end
  def self.make_secret_answer2
    Faker::Address.city
  end
  def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'Cash Only'],
      ["checks",    'Personal Checks'],
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'American Express'],
      ["discover",  'Discover'],
      ["diners",    'Diners Club']
    ].each do |row|
      methods[row[0]] = row[1]
    end
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    accepted
  end
  def email_available(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ //
        if mail.body =~ //
          @link = $1
        end
      end
    end
    @link
  end


def self.get_hours(business)
hours = {}
days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday']
  days.each do |day|
    if business.send("#{day}_enabled".to_sym) == true
      hours[ "#{day}" ] =
          {
            "open" => business.send("#{day}_open".to_sym).downcase.gsub("am"," a.m.").gsub("pm"," p.m."),
            "close" => business.send("#{day}_close".to_sym).downcase.gsub("am"," a.m.").gsub("pm"," p.m.")
          }
        
    else
      hours[ "#{day}" ] = "closed"
    end
  end

  return hours
end 









end
