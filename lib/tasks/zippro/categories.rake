require 'json'

namespace :zippro do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Zippro", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    categories.each_pair do |root,sub|
      puts(root.to_s)
      puts(sub[0].to_s)
      
      sleep(5)
      #rootInsert = ZipproCategory.create(:name => root.to_s)
        sub['sub1'].each_pair do |root2, sub2|
          puts(" > " + root2.to_s)
       #   rootInsert2 = rootInsert.children.create(:name => root2.to_s)
          sub2['sub2'].each_pair do |root3, sub3|
              puts(" > > " + root3.to_s)
        #      rootInsert3 = rootInsert2.children.create(:name => root3.to_s)
              if sub3['sub3']
                sub3['sub3'].each_pair do |root4, sub4|
                    puts(" > > > " + sub4.to_s)
         #           rootInsert4 = rootInsert3.children.create(:name => sub4.to_s)                    
                end
              end
          end
        end
    end
    
    
    
    
    
	
	#root = ZipproCategory.create(:name => k)		
	
	
	
			#cat = root.children.create(:name => sub)
	end	
end
