class Yelp < ClientData
  attr_accessible       :email, :yelp_category_id
  virtual_attr_accessor :password
  belongs_to            :yelp_category
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Verify Your Email Address/i
		if mail.body.decoded =~ /(https:\/\/biz.yelp.com\/signup\/confirm\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  

end
