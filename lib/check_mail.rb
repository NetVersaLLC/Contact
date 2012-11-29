class CheckMail

  def self.get_link(business, &block)
    Mail.defaults do
      retriever_method :pop3, {
        :address      => 'pop3.live.com',
        :port         => 995,
        :user_name    => business.bings.first.email,
        :password     => business.bings.first.password,
        :enable_ssl   => true
      }
    end
    Mail.all.each do |mail|
      block(mail)
    end
  end

end
