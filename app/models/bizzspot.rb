class Bizzspot < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password  

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /BizzSpot Account Activation/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /http:\/\/www.bizzspot.com\/*/
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Bizzspot link: #{@link}"
    @link
end
end