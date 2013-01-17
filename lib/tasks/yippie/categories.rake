namespace :yippie do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Yippie", "categories.txt"), 'r').each do |line|
	next if line == ""
      YippieCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
