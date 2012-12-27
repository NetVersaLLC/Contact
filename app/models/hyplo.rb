class Hyplo < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true

def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
	    puts(mail.subject)
      if mail.subject =~ /Hyplo\.com: Please confirm your account/i
	      puts(mail.subject)
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/www.hyplo.com\/account\/confirm_account.php/i
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
