class Yellowise  < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true


  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /LocalXML Business Claiming Sign Up/i
		nok = Nokogiri::HTML(mail.body.decoded)
		@link = nok.xpath("//a")[1].inner_html #attr('href')
      end
    end
    @link
  end

end
