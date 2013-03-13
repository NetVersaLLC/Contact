class Digabusiness < ClientData
  attr_accessible :digabusiness_category_id, :email
  virtual_attr_accessor :password

  belongs_to            :digabusiness_category

def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'pm3'],
      ["checks",    'pm4'],
      ["visa",      'pm0'],
      ["mastercard",'pm1'],
      ["amex",      'pm2'],
      ["paypal",    'pm7']
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
