class Kudzu < ClientData
  attr_accessible :username
  virtual_attr_accessor :password, :secret_answer

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6).gsub(/[^A-Za-z0-9]/, '')
  end
  def self.make_secret_answer
    Faker::Address.city
  end
  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Please confirm your Kudzu profile/
        if mail.body =~ /(https:\/\/register.kudzu.com\/confirmEmail.do?confirmCode=\S+)/
          @link = $1
        end
      end
    end
    @link
  end

end
