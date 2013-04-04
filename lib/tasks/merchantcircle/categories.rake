require 'json'

namespace :merchantcircle do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Merchantcircle", "categories.json"), 'r').read
    categories = JSON.parse(body) 
 

root = MerchantcircleCategory.create(:name => 'root')
 categories.each_pair do |k,v| 
    node = MerchantcircleCategory.create(:name => k, :parent_id => root.id)  
    puts(k)
    v.each_pair do |aa, sub|
        puts(" > " + aa)
        cat = node.children.create(:name => aa, :parent_id => node.id)

        sub.each do |sub2|
            puts(" > > "+sub2)
            cat2 = cat.children.create(:name => sub2, :parent_id => cat.id)
        end
    end




 end


end
end