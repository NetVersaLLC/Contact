require 'json'

namespace :yellowtalk do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Yellowtalk", "categories.json"), 'r').read
   categories = JSON.parse(body) 
   root = YellowtalkCategory.create(:name => 'root')
   categories.each do |k| 
   node = YellowtalkCategory.create(:name => k, :parent_id => root.id)  
   puts(k)
   end   
  end
end