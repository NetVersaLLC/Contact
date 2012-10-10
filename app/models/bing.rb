class Bing < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true

  def make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def make_secret_answer
    Faker::Name.first_name
  end

  def get_category(business)
    nil
  end

  def make_payments(business)
    methods = {
      'cash'       => 'Cash',
      'checks'     => 'Checks',
      'mastercard' => 'Mastercard',
      'visa'       => 'Visa',
      'discover'   => 'Discover',
      'diners'     => "Diner's Club",
      'amex'       => 'American Express',
      'paypal'     => 'Paypal online'
    }
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    accepted
      # 'financing' => 'Financing',
      # 'foodstamps' => 'Food stamp',
      # 'giftcard' => 'Gift card',
      # 'invoice' => 'Invoice',
      # 'jcb' => 'JCB',
      # 'travel' => "Traveler's check" }
  end
end
