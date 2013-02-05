namespace :ebusinesspage do
  task :categories => :environment do
root = EbusinesspageCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Ebusinesspages", "final_list.txt"), 'r').each do |line|
	next if line == ""
      EbusinesspageCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 