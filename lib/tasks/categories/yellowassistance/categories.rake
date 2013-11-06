namespace :yellowassistance do
  task :categories => :environment do
root = YellowassistanceCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Yellowassistance", "categories.txt"), 'r').each do |line|
	next if line == ""
      YellowassistanceCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 