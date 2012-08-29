namespace :jobs do
  task :add => :environment do
    business_id    = ENV['business_id']
    payload        = ENV['payload']
    data_generator = ENV['data_generator']
  end
end
