namespace :build do
  task :menu => :environment do
    puts YelpCategory.build_menu
  end
end
