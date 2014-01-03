class Bing < ClientData
  attr_accessible :email, :bing_category_id, :listing_url
  virtual_attr_accessor :password, :secret_answer
  belongs_to :bing_category
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def self.make_secret_answer
    begin
      name = Faker::Name.first_name
    end while name.length < 5
    name
  end

  def get_category
    self.bing_category.name
  end

  def self.make_payments(business)
    methods = {
      'cash'       => 'AdditionalBusinessInfo_PaymentOptions_1__Selected',
      'checks'     => 'AdditionalBusinessInfo_PaymentOptions_9__Selected',
      'mastercard' => 'AdditionalBusinessInfo_PaymentOptions_18__Selected',
      'visa'       => 'AdditionalBusinessInfo_PaymentOptions_20__Selected',
      'discover'   => 'AdditionalBusinessInfo_PaymentOptions_14__Selected',
      'diners'     => 'AdditionalBusinessInfo_PaymentOptions_2__Selected',
      'amex'       => 'AdditionalBusinessInfo_PaymentOptions_0__Selected',
      'paypal'     => 'AdditionalBusinessInfo_PaymentOptions_12__Selected'
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
