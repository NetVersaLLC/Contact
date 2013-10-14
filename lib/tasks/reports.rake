namespace :reports do
  desc "Make all complted reports as completed"
  task :update_status => :environment do
    Report.update_statuses
  end
end