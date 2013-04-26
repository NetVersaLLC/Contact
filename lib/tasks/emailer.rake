namespace :emailer do 

  desc "EMail reminders to users who have not downloaded the client setup"
  task :download_reminder => :environment do 
    c = 0
    User.needs_to_download_client.each do |user| 
      UserMailer.download_client_reminder_email(user).deliver
      c += 1
    end
    puts "#{c} reminders sent" 
  end 
end 

