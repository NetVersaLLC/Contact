namespace :insider_page do
  task :categories => :environment do
root = InsiderPageCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Insiderpages", "categoryFinal.txt"), 'r').each do |line|
	next if line == ""
      InsiderPageCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 