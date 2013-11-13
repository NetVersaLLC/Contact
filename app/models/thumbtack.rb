class Thumbtack < ClientData
  attr_accessible :email
  virtual_attr_accessor :password

  def has_categories? 
    false
  end 


  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Activate your Thumbtack.com account/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /http:\/\/www.thumbtack.com\/activate\?/
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Thumbtack link: #{@link}"
    @link
end

end



