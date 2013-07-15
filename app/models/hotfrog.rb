class Hotfrog < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Validate your profile on Hotfrog/i
		if mail.body.decoded =~ /(http:\/\/www.hotfrog.com\/\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end
end
