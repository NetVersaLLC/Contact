class Uscity < ClientData
  attr_accessible :email, :secret_answer
  virtual_attr_accessor :password
  belongs_to :uscity_category

  def self.make_secret_answer
    Faker::Name.first_name
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /sign up email/i			  
        nok = Nokogiri::HTML(mail.body.decoded)
        links = nok.css("a")
        @link = links[0]["href"]        
      end
    end
    @link
  end


end
