class Mywebyellow < ClientData
  attr_accessible :business_id, :email, :force_update, :secrets, :status
  virtual_attr_accessor :password
  
  def has_categories? 
    false
  end 

  def self.payment_methods(business)
    methods = {}
    [
      ["amex",      'ctl00_ContentPlaceHolder01_chkAcceptedPayment_0'],
      ["visa",      'ctl00_ContentPlaceHolder01_chkAcceptedPayment_1'],
      ["mastercard",'ctl00_ContentPlaceHolder01_chkAcceptedPayment_2'],
      ["discover",  'ctl00_ContentPlaceHolder01_chkAcceptedPayment_3'],
      ["checks",    'ctl00_ContentPlaceHolder01_chkAcceptedPayment_4'],
      ["paypal",    'ctl00_ContentPlaceHolder01_chkAcceptedPayment_5']
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
