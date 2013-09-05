namespace :payloads do
  task :find_missed => :environment do
    business = Business.find(203)
    missed = PayloadNode.find_missed_payloads(business)
    ap missed
  end
end
