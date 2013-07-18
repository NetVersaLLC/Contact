class Localeze  < ClientData
	attr_accessible :localeze_category_id, :email
	virtual_attr_accessor :password
  belongs_to            :localeze_category

   def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Activate Your Account/i
		if mail.body.decoded =~ /(http:\/\/www.neustarlocaleze.biz\/directory\/\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  
end
