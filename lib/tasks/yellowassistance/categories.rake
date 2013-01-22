namespace :yellowassistance do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Yellowassistance", "categories.txt"), 'r').each do |line|
      YellowassistanceCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
