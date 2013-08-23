namespace :payload do
  task :work => :environment do
    business = Business.find(203)
    root = PayloadNode.root
    missing = root.get_missing_jobs(business)
    ap missing
  end
end
