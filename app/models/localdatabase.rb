class Localdatabase < ClientData
  attr_accessible :username
  virtual_attr_accessor :password

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
	    puts(mail.subject)
	STDERR.puts mail.subject
      if mail.subject =~ /Action Required to Activate Membership for Local Database/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /http:\/\/www.localdatabase.com\/forum\/register.php\?a=act/i
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Localdatabase link: #{@link}"
    @link
  end

end
