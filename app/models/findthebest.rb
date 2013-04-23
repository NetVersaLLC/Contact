class Findthebest < ClientData
	attr_accessible :email
	virtual_attr_accessor :password
	belongs_to :findthebest_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Thank you for Registering at FindTheBest.com/i
		if mail.body.decoded =~ /(http:\/\/www.findthebest.com\/user\/validate\/\S+)/i
			puts(mail.body.decoded)
	          @link = $1
	        end
  	end
    end
    @link
 end  



end
