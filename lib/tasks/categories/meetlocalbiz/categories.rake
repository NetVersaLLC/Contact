require 'json'

namespace :meetlocalbiz do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Meetlocalbiz", "categories.json"), 'r').read
    categories = JSON.parse(body) 

   root = MeetlocalbizCategory.create(:name => 'root')
 	categories.each do |k| 
 		node = MeetlocalbizCategory.create(:name => k, :parent_id => root.id)  
  		puts(k)
 	end
  end
end