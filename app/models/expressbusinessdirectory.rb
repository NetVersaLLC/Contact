class Expressbusinessdirectory < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true

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

	
end
