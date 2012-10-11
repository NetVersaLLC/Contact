class Bing < ClientData
  attr_accessible :email, :bing_category_id
  virtual_attr_accessor :password, :secret_answer
  belongs_to :bing_category
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def self.make_secret_answer
    Faker::Name.first_name
  end

  def get_category
    self.bing_category.name
  end

  def self.make_payments(business)
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
