class Yelp  < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to :yelp_category

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Confirm Your Email Address/i
      puts(mail.subject)
		if mail.body.decoded =~ /(https:\/\/biz.yelp.com\/signup\/confirm\S+)/i
      puts(mail.body.decoded)
	          @link = $1
            puts(@link)
	        end
  	end
    end
    @link
 end  

end
