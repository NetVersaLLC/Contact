namespace :package do
  task :tadd, [:business_id] => [:environment] do 
    business = Business.find(args[:business_id])
    business.create_jobs
  end
end
