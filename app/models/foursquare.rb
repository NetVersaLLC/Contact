class Foursquare < ClientData
  attr_accessible :email, :foursquare_category_id
  virtual_attr_accessor :password
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

belongs_to :foursquare_category

def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
    	if mail.subject =~ /welcome to Foursquare! Verify your email to finish setting up your account./i
      		mail.parts.map do |p|
        		if p.content_type =~ /text\/html/
          		nok = Nokogiri::HTML(p.decoded)
					nok.xpath("//a").each do |tink|
						if tink.text == "Verify"
            				@link = tink.attr('href')
            				puts(@link)
						end
					end          
        		end
      		end
    	end
    end
    @link
end



end
