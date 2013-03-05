class Spotbusiness < ClientData
  attr_accessible :business_id, :created_at, :email, :force_update, :secrets, :updated_at
  virtual_attr_accessor :password
  validates :password,
  	:presence => true

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Spotabusiness - Your Registration is Pending Approva/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
                nok.xpath("//a").each do |tink|
                        if tink.attr('href') =~ /http:\/\/spotabusiness.com\/index.php/i
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
