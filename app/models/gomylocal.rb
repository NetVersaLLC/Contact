class Gomylocal < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	belongs_to :gomylocal_category


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  		if mail.subject =~ /#{business.business_name} - Gomylocal/
			nok = Nokogiri::HTML(mail.body.decoded)
			@link = nok.xpath("//a").attr('href')
  		end
    end
    @link
 end  

end
