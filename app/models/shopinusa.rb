class Shopinusa < ClientData
	attr_accessible :username, :shopinusa_category_id, :shopinusa_category
	virtual_attr_accessor :password
	validates :password,
            :presence => true



  def self.payment_methods(business)
    methods = {}
    [
      ["cash",      '5'],
      ["checks",    '4'],
      ["visa",      '0'],
      ["mastercard",'1'],
      ["amex",      '2'],
      ["discover",  '7'],
      ["diners",    '8']
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
