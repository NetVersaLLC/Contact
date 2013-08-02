namespace :business do

  desc "EMail informs the user their business's setup completed"
  task :notify_setup_completed => :environment do 
    businesses = Business.setup_completed_not_reported
    businesses.each do |business|
      UserMailer.setup_completed_email(business).deliver
      business.setup_msg_sent = true
      business.save
    end
  end

end
