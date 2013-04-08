class Spotbusiness < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to :spotbusiness_category



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
