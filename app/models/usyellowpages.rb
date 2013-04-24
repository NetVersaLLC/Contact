class Usyellowpages < ClientData 
  attr_accessible 		:email
  virtual_attr_accessor :password
  belongs_to            :usyellowpages_category


  def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'Group-0-PaymentOption_Cash'],
      ["checks",    'Group-0-PaymentOption_Check'],
      ["visa",      'Group-0-PaymentOption_Visa'],
      ["mastercard",'Group-0-PaymentOption_Master-Card'],
      ["amex",      'Group-0-PaymentOption_American-Express'],
      ["discover",  'Group-0-PaymentOption_Discover'],
      ["diners",    'Group-0-PaymentOption_Diners']
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
  
end
