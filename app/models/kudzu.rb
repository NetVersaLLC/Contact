class Kudzu < ClientData
  attr_accessible :username
  virtual_attr_accessor :password, :secret_answer

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
