class Magicyellow < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to            :magicyellow_category	


   def self.check_email(business)
    	@email = nil
    	@password = nil
    	CheckMail.get_link(business) do |mail|
  			if mail.subject =~ /Your MagicYellow.com Business Center Login Info/i
				puts(mail.body.decoded)
				if mail.body.decoded =~ /Login: (\S+)/i
	          		@email = $1
		        end
		        if mail.body.decoded =~ /Password: (\S+)/i
	          		@password = $1
		        end
  			end
    	end
    	puts("Password: "+@password+" email: "+@email)
    	return @password,@email
	end  

  def self.payments(business) 
    p = []
    p << '11' if business.accepts_cash 
    p << '6'  if business.accepts_checks
    p << '2'  if business.accepts_mastercard
    p << '1'  if business.accepts_visa
    p << '4'  if business.accepts_discover
    p << '8'  if business.accepts_diners
    p << '3' if business.accepts_amex
    p << '9'  if business.accepts_paypal
    #p << '11' if business.accepts_bitcoin
    p
  end 

end
