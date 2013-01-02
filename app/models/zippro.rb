class Zippro < ClientData
	attr_accessible :username, :secret1
	virtual_attr_accessor :password
	validates :password,
            :presence => true


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

end
