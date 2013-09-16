class Brownbook < ClientData 
  attr_accessible :business_id, :email, :force_update, :secrets
  virtual_attr_accessor :password

 def self.check_email( business )
    @link = nil
    CheckMail.get_link( business ) do |mail|
  		if mail.subject =~ /Brownbook - Confirm registration/i
			  if mail.body.decoded =~ /(http:\/\/www.brownbook.net\/user\/confirm_account\/\S+)/i
	     	  @link = $1
	      end
  		end
    end
    return @link
 end  

end
