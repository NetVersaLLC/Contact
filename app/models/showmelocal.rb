class Showmelocal < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Welcome to the ShowMeLocal\.com/i
	          @link = mail.body.decoded.match(/(http:\/\/www.showmelocal.com\S+)/i)[1]
  	end
    end
    @link
 end  

	




end
