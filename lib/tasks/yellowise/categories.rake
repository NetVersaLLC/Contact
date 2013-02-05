namespace :yellowise do
  task :categories => :environment do
root = YellowiseCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Yellowise", "finalCategories.txt"), 'r').each do |line|
	next if line == ""
      YellowiseCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 