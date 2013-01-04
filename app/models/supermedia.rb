class Supermedia < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Action Required: Confirm Your SuperMedia Account/i
		if mail.body.decoded =~ /(http:\/\/click.reply.supermedia.com\/\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  



 def self.get_password(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Action Required: Confirm Your SuperMedia Account/i
		if mail.body.decoded =~ /Temporary Password: (.*)<\/td>/i
	          @link = $1
	        end
  	end
    end
    @link
 end  


end
