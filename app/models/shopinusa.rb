class Shopinusa < ClientData
  #attr_accessible :shopinusa_category_id
  belongs_to :shopinusa_category

  def self.payment_methods(business)
    methods = {}
    methods = [:cash,:checks,:visa,:mastercard,:amex,:discover,:diners]
    accepted = []
    methods.each do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push type
      end
    end
    accepted
  end
end
