#!/usr/bin/env ruby

require 'mail'

Mail.defaults do
    retriever_method :imap, { :address => "mail.blazingdev.com",
                              :port => 993,
                              :user_name => 'jonathan',
                              :password => 'uE6olSzDx6',
                              :enable_ssl => true }
end

Mail.all.each do |mail|
    puts mail.subject
end
