require 'resolv'

namespace :check do
  task :email => :environment do
    username = ENV['user']
    password = ENV['pass']

    settings = CheckMail.get_settings(username)
    STDERR.puts "Settings: #{settings.inspect}"
  end
end
