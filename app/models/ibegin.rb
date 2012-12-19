class Ibegin < ClientData
attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true



def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'pay_cash'],
      ["checks",    'pay_check'],
      ["visa",      'pay_visa'],
      ["mastercard",'pay_mastercard'],
      ["amex",      'pay_discover'],
      ["discover",  'pay_discover'],
      ["diners",    'pay_dinersclub']
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
