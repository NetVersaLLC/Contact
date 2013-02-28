class Uscity < ClientData
  attr_accessible :business_id, :created_at, :email, :force_update, :secrets, :updated_ati
  virtual_attr_accessor :password
  validates :password,
        :presence => true


  def self.make_secret_answer
    Faker::Name.first_name
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /sign up email/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
		nok.xpath("//a").each do |tink|
			if tink.attr('href') =~ /http:\/\/uscity.net\/account\/thanks\//i
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
