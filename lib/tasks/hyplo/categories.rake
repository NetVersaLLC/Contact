namespace :hyplo do
  task :categories => :environment do
root = HyploCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Hyplo", "categories.txt"), 'r').each do |line|
	next if line == ""
      HyploCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 