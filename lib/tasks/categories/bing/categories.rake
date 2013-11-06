namespace :bing do
  task :categories => :environment do
root = BingCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Bing", "categories.txt"), 'r').each do |line|
	next if line == ""
      BingCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 