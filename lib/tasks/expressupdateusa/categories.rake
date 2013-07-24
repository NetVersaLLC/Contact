namespace :expressupdateusa do
  task :categories => :environment do
root = ExpressupdateusaCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Expressupdateusa", "categories.txt"), 'r').each do |line|
	next if line == ""
      ExpressupdateusaCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 