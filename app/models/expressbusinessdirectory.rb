class Expressbusinessdirectory < ClientData
	attr_accessible :username
	virtual_attr_accessor :password

  def has_categories? 
    false
  end 

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Updating #{business.business_name} on ExpressBusinessDirectory/i
		if mail.body.decoded =~ /(http:\/\/www.expressbusinessdirectory.com\/claimbusiness\/verifyclaim.aspx\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  

def self.check_email2(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Verify Email for #{business.business_name} on ExpressBusinessDirectory/i
		if mail.body.decoded =~ /(http:\/\/www.expressbusinessdirectory.com\/claimbusiness\/verifyBusinessEmail.aspx\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  
	
end
