require 'json'

namespace :cornerstoneworld do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Cornerstoneworld", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = CornerstonesworldCategory.create(:name => 'root')
	categories.each do |v|	
	node = CornerstonesworldCategory.create(:name => v, :parent_id => root.id)		
		puts(v)	
  end
  end
end
 