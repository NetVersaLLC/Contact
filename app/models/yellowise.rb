class Yellowise  < ClientData
  attr_accessible :username, :yellowise_category_id, :yellowise_category
  virtual_attr_accessor :password
  validates :password,
            :presence => true
belongs_to :yellowise_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /LocalXML Business Claiming Sign Up/i
        nok   = Nokogiri::HTML(mail.body.decoded)
        @link = nok.xpath("//a")[1].inner_html #attr('href')
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
