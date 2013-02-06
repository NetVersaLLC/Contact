class Kudzu < ClientData
  attr_accessible :username, :kudzu_category_id
  virtual_attr_accessor :password, :secret_answer
belongs_to            :kudzu_category
  
  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6).gsub(/[^A-Za-z0-9]/, '')
  end
  def self.make_secret_answer
    Faker::Address.city
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Please confirm your Kudzu profile/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /https:\/\/register.kudzu.com\/confirmEmail.do\?confirmCode=/
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Kudzu link: #{@link}"
    @link
end

end
