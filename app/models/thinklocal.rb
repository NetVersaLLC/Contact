class Thinklocal < ClientData 
  attr_accessible :email
  virtual_attr_accessor :password

def self.payment_methods(business)
    methods = {}
    [
      ["cash", 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkCash'],
      ["checks", 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkChecks'],
      ['diners', 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkDiners'],
      ["visa", 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkVisa'],
      ["mastercard",'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkMasterCard'],
      ["amex", 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkAmex'],
      ["discover", 'ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_chkDiscover']
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
