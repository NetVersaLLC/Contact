namespace :package do
  task :add, :business_id, :needs => :environment do |t,args|
    business = Business.find(args[:business_id])
    business.create_jobs
  end
end
