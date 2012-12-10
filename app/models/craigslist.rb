class Craigslist < ClientData
  attr_accessible :email
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /craigslist.org: New Craigslist Account/i
	      STDERR.puts "subject found"
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /https:\/\/accounts.craigslist.org\/pass/i
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Expressupdate link: #{@link}"
    @link
  end

def self.confirm_post_url(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /POST\/EDIT\/DELETE :/i
	      STDERR.puts "subject found"
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /https:\/\/post.craigslist.org\/u\//i
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Expressupdate link: #{@link}"
    @link
  end


end
