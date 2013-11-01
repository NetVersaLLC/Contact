require 'json'

namespace :magicyellow do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Magicyellow", "categories.json"), 'r').read
    categories = JSON.parse(body) 
 
root = MagicyellowCategory.create(:name => 'root')
    categories.each do |v| 
      node = MagicyellowCategory.create(:name => v, :parent_id => root.id)  
        puts(v)     
    end
  end
end