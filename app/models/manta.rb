class Manta < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
belongs_to :manta_category
  def has_categories? 
    false
  end 

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      # STDERR.puts "Examining: #{mail.subject}"
      if mail.subject =~ /MerchantCircle Registration Confirmation/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            # STDERR.puts "Body: #{p.decoded}"
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              # STDERR.puts "Link: #{link.attr('href')}"
              if link.attr('href') =~ /merchantcircle\.com\/r\?a=/
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    @link
  end
end
