require 'resolv'

namespace :check do
  task :email do
    email    = 'dumpstersonline@hotmail.com'

    method   = :pop3
    username = 'dumpstersonline@hotmail.com'
    password = 'hotfiya6!'
    port     = 995
    host     = 'pop3.live.com'
    ssl      = true

    address  = Mail::Address.new(email)
    if address.domain.downcase == 'live.com'
      method   = :pop3
      host     = 'pop3.live.com'
      port     = 995
      ssl      = true
    elsif address.domain.downcase == 'hotmail.com'
      method   = :pop3
      host     = 'pop3.live.com'
      port     = 995
      ssl      = true
    else
      resolver = Resolv::DNS.new
      mx       = resolver.getresource(address.domain, Resolv::DNS::Resource::IN::MX)
      server   = mx.exchange
    end

    Mail.defaults do
      retriever_method  method, :address => host,
                        :port           => port,
                        :user_name      => username,
                        :password       => password,
                        :enable_ssl     => ssl
    end

    Mail.all.each do |mail|
      STDERR.puts mail.subject
    end
  end
end
