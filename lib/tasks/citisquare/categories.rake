require 'json'

namespace :citisquare do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Citisquare", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	categories.each_pair do |k,v|	
	root = CitisquareCategory.create(:name => k)		
		puts(k)
		v.each do |sub|
			puts(" > " + sub)
			cat = root.children.create(:name => sub)
		end			
	end				
  end
end
