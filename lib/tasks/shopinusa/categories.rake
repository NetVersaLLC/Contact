require 'json'

namespace :shopinusa do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Shopinusa", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	categories.each_pair do |k,v|	
	root = ShopinusaCategory.create(:name => k)		
		puts(k)
		v.each do |sub|
			puts(" > " + sub)
			cat = root.children.create(:name => sub)
		end			
	end				
  end
end
