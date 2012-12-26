class Yellowise  < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /LocalXML Business Claiming Sign Up/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/xml.localxml.com\/index.php\/auth\/activate\//i
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
