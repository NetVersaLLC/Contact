class Jayde < ClientData
  
  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Please Confirm Your Jayde Listing/i
        puts mail
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |tink|
              if tink.attr('href') =~ /confirm.srv/ #/http:\/\/confirm.mailmime.com\/confirm.srv\//i
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
