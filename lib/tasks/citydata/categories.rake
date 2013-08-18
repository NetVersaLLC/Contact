require 'json'

namespace :citydata do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Citydata", "categories.json"), 'r').read
    categories = JSON.parse(body) 

   root = CitydataCategory.create(:name => 'root')
 	categories.each do |k| 
 		node = CitydataCategory.create(:name => k, :parent_id => root.id)  
  		puts(k)
 	end
  end
end