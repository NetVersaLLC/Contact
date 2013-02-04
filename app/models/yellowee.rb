class Yellowee < ClientData
	attr_accessible :username, :yellowee_category_id, :yellowee_category
	virtual_attr_accessor :password
	validates :password,
            :presence => true
  belongs_to :yellowee_category

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Please complete your Yellowee Registration and be part of your city/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/biz.yellowee.com\/user\/activate\//i
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
