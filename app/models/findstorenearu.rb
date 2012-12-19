class Findstorenearu  < ClientData
	attr_accessible :email
	virtual_attr_accessor :password

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Activate Your Listing/i
		nok = Nokogiri::HTML(mail.body.decoded)
		@link = nok.xpath("//a")[1].attr('href')
      end
    end
    @link
  end


end

