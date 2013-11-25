namespace :ycphonebook do
  task :categories => :environment do
root = YcphonebookCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Ycphonebook", "categories.txt"), 'r').each do |line|
	next if line == ""
      YcphonebookCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 