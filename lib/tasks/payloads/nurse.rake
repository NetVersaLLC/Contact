namespace :payloads do
  task :nurse => :environment do
    Subscription.where(:active => true).each do |sub|
      business = sub.business
      if business.mode_id == 1
      elsif business.mode_id = 2
      else
      end
    end
  end
end
