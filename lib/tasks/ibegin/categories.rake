namespace :ibegin do
  task :categories => :environment do
root = IbeginCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Ibegin", "categories.txt"), 'r').each do |line|
	next if line == ""
      IbeginCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 