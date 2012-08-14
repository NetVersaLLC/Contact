class CheckMail
  def self.get_link(business, &block)
    Mail.defaults do
      retriever_method :imap, { :address => business.mail_host,
      :port                              => business.mail_port,
      :user_name                         => business.mail_username,
      :password                          => business.mail_password,
      :enable_ssl                        => true }
    end
    Mail.all.each do |mail|
      block(mail)
    end
  end
end
