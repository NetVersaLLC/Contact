class Yellowassistance < ClientData
	attr_accessible :username, :yellowassistance_category_id, :yellowassistance_category
	virtual_attr_accessor :password
belongs_to :yellowassistance_category

def self.payment_methods(business)
    methods = {}
    [
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'AmEx'],
      ["discover",  'Discover'],
      ["diners",    'Diners']
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
