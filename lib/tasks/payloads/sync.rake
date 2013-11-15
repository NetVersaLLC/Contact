namespace :payloads do
  task :git_to_database => :environment do
    system "cd #{Rails.root.join('sites')}; git pull origin master;"
    Payload.git_to_database
  end
  task :database_to_git => :environment do
    Payload.database_to_git
  end
end
