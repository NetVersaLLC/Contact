require 'json'

namespace :digabusiness do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Digabusiness", "categories.json"), 'r').read
    categories = JSON.parse(body) 
 

	 root = DigabusinessCategory.create(:name => 'root')
 categories.each_pair do |k,v| 
 node = DigabusinessCategory.create(:name => k, :parent_id => root.id)  
  puts(k)
  v.each do |sub|
   puts(" > " + sub)
   cat = node.children.create(:name => sub, :parent_id => node.id)
  end   
 end
  end
end