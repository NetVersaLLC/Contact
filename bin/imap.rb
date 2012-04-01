#!/usr/bin/env ruby

require 'net/imap'

imap = Net::IMAP.new('mail.blazingdev.com', 993, true, nil, false)
imap.authenticate('LOGIN', 'jonathan', 'uE6olSzDx6')
imap.examine('INBOX')
imap.search(["RECENT"]).each do |message_id|
  envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
  puts "#{envelope.from[0].name}: \t#{envelope.subject}"
end

