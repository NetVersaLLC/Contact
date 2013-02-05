require 'json'

namespace :shopinusa do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Shopinusa", "categories.json"), 'r').read
    categories = JSON.parse(body) 

   root = ShopinusaCategory.create(:name => 'root')
 categories.each_pair do |k,v| 
 node = ShopinusaCategory.create(:name => k, :parent_id => root.id)  
  puts(k)
  v.each do |sub|
   puts(" > " + sub)
   cat = node.children.create(:name => sub, :parent_id => node.id)
  end   
 end
  end
end
 