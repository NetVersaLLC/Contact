require 'json'

namespace :foursquare do
      task :categories => :environment do
	     body = File.open(Rails.root.join("categories", "Foursquare", "categories.json"), 'r').read
        categories = JSON.parse(body)

Aroot = FoursquareCategory.create()  

        categories["response"]["categories"].each do |cats|    
        rootInsert = Aroot.children.create(:name => cats["name"])
          puts(cats["name"])
            cats["categories"].each do |sub1|
              rootInsert2 = rootInsert.children.create(:name => sub1["name"])
              puts(" > " + sub1["name"])
                sub1["categories"].each do |sub2|
                  rootInsert3 = rootInsert2.children.create(:name => sub2["name"])
                    puts(" > > " + sub2["name"])
                end        
            end
        end
	   end	
end

