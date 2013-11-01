namespace :adsolutionsyp do
  task :categories => :environment do
root = AdsolutionsypCategory.create(:name => 'root')  

	thefile = File.open(Rails.root.join("categories", "Adsolutionsyp", "categories.txt"), 'r').read.split("@")	

  thefile.each do |line|
	next if line == ""
      AdsolutionsypCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 