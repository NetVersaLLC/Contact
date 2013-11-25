namespace :bigwigbiz do
  task :categories => :environment do
root = BigwigbizCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Bigwigbiz", "categories.txt"), 'r').each do |line|
	next if line == ""
	  line.chomp!
      BigwigbizCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 