class Zippro < ClientData
	attr_accessible :username, :secret1, :zippro_category_id, :zippro_category2_id 
	virtual_attr_accessor :password
belongs_to :zippro_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Zip.pro - Account Activation/i
		if mail.body.decoded =~ /(http:\/\/myaccount.zip.pro\/verify.php\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  


def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'payOpt[1]'],
      ["checks",    'payOpt[2]'],
      ["visa",      'payOpt[3]'],
      ["mastercard",'payOpt[4]'],
      ["amex",      'payOpt[6]'],
      ["discover",  'payOpt[5]'],
      ["diners",    'payOpt[7]']
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
#14857
#10493
