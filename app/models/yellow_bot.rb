class YellowBot < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  
  
  
def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /YellowBot/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /https:\/\/www.yellowbot.com\/account\/welcome\//i
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
