class Cornerstonesworld < ClientData
	attr_accessible :username, :cornerstornesworld_category_id
	virtual_attr_accessor :password
	validates :password,
            :presence => true
  belongs_to :cornerstoneworld_category


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  if mail.subject =~ /Welcome to CornerstonesWorld/i
              nok = Nokogiri::HTML(mail.body.decoded)
		@link = nok.xpath("//a")[0].attr('href')
      end
    end
    @link
  end
  
  def self.check_email_username(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  if mail.subject =~ /CornerstonesWorld.com Username/i
		if mail.body.decoded =~ /<div style="font-size:14px; font-weight:bold;">(.*)<\/div>/
          		@link = $1
	        end
	  
		#<div style="font-size:14px; font-weight:bold;">c88925</div>
      end
    end
    @link
  end
	

end
