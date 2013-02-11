class Localpages < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	

  def self.check_email(business)
    @password = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Thank you for registering on localpages.com/i
		if mail.body.decoded =~ /Password: (.*\S+)<br><br>/i
	          @password = $1
	        end
  	end
    end
    @password
  end

end
