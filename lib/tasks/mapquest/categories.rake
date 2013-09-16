namespace :mapquest do
  task :categories => :environment do
root = MapquestCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "MapQuest", "categories.txt"), 'r').each do |line|
	next if line == ""
      MapquestCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 