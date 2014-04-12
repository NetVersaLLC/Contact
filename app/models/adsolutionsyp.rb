class Adsolutionsyp < ClientData
	attr_accessible :email, :secret_answer
	virtual_attr_accessor :password
	belongs_to :adsolutionsyp_category
def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'SelectedPaymentOptions_12'],
      ["checks",    'SelectedPaymentOptions_7'],
      ["paypal",	'SelectedPaymentOptions_8'],
      ["visa",      'SelectedCreditCards_2'],
      ["mastercard",'SelectedCreditCards_3'],
      ["amex",      'SelectedCreditCards_4'],
      ["discover",  'SelectedCreditCards_5'],
      ["diners",    'SelectedCreditCards_11']
    ].each do |row|
      methods[row[0]] = row[1]
    end
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push type #methods[type]
      end
    end
    accepted
  end

  def self.get_hours(business)
    hours = {}
    hours[:days_open] = []
    time_regex = /(\d\d):(\d\d)(\w\w)/
    days = {
      
    }
  end

end
