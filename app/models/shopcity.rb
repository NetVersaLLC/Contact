class Shopcity < ClientData
	attr_accessible :username, :shopcity_category_id
	virtual_attr_accessor :password
belongs_to :shopcity_category

def self.payment_methods(business)
    methods = {}
    [
      ["visa",      'pay1008'],
      ["mastercard",'pay1009'],
      ["amex",      'pay1010'],
      ["discover",  'pay1012'],
      ["diners",    'pay1011'],
      ["cash",      'pay1006'],
      ["paypal",    'pay1022']            
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
