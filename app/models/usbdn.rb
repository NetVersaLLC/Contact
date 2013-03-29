class Usbdn < ClientData
	attr_accessible :username, :usbdn_category_id, :usbdn_category
	virtual_attr_accessor :password
belongs_to :usdbn_category

def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /USBDN\.com User Activation/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/www.USBDN.com\/UserActivation\.asp/i
            			@link = tink.attr('href')
			end
		end
          end
        end
      end
    end
    @link
  end
	


end
