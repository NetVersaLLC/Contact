namespace :yellowise do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Yellowise", "finalCategories.txt"), 'r').each do |line|
	next if line == ""
      YellowiseCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
