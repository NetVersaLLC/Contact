namespace :snoopitnow do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Snoopitnow", "categories.txt"), 'r').each do |line|
      SnoopitnowCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
