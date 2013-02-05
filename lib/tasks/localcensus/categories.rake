namespace :localcensus do
  task :categories => :environment do
root = LocalcensusCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Localcensus", "categories.txt"), 'r').each do |line|
	next if line == ""
      LocalcensusCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 