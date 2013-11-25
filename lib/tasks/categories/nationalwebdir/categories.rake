namespace :nationalwebdir do
  task :categories => :environment do
root = NationalwebdirCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Nationalwebdir", "categories.txt"), 'r').each do |line|
	next if line == ""
	  line.chomp!
      NationalwebdirCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 