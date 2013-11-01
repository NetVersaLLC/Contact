require 'json'

namespace :gomylocal do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Gomylocal", "categories.json"), 'r').read
    categories = JSON.parse(body) 

theroot = GomylocalCategory.create
     categories.each_pair do |root,sub|
      puts(root)
      rootInsert = theroot.children.create(:name => root)    
        sub.each_pair do |root2, sub2|
          rootInsert2 = rootInsert.children.create(:name => root2.to_s)
          puts(" > " +root2.to_s)
          next if sub2.to_s == ""
          sub2.each do |sub3|
            rootInsert3 = rootInsert2.children.create(:name => sub3)
            puts(" > > " + sub3)
          end
        end
    end
    
    
    
	
	#root = ZipproCategory.create(:name => k)		
	
	
	
			#cat = root.children.create(:name => sub)
	end	
end
