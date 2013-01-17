namespace :localcensus do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Localcensus", "categories.txt"), 'r').each do |line|
      LocalcensusCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
