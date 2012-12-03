class Yahoo < ClientData
  attr_accessible       :email, :yahoo_category_id
  virtual_attr_accessor :password, :secret1, :secret2
  belongs_to            :yahoo_category

  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

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
end
