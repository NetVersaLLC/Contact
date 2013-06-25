class Linkedin < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
#  validates :email,
#            :presence => true,
#            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
#  validates :password,
#            :presence => true


  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Please confirm your email address/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            @link = nok.xpath("//a")[0].attr('href')
          end
        end
      end
    end
    STDERR.puts "Linkedin link: #{@link}"
    @link
  end



end
