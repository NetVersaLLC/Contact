class Patch < ClientData 
  attr_accessible 		:email
  virtual_attr_accessor :password


  
 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Verify your Patch account/i
		if mail.body.decoded =~ /(http:\/\/www.patch.com\/activate\/\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  


end
