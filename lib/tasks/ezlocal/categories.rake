namespace :ezlocal do
  task :categories => :environment do
root = EzlocalCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Ezlocal", "categories.txt"), 'r').each do |line|
	next if line == ""
      EzlocalCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 