class Localizedbiz < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true

def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Activation email from LocalizedBiz/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/www.localizedbiz.com\/login\/confirm.php/i
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
