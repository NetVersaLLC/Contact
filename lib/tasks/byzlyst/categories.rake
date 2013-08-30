namespace :byzlyst do
  task :categories => :environment do
root = ByzlystCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Byzlyst", "categories.txt"), 'r').each do |line|
	next if line == ""
      ByzlystCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end