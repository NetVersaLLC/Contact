require 'json'

namespace :cornerstoneworld do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Cornerstoneworld", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	categories.each do |v|	
	root = CornerstoneworldCategory.create(:name => v)		
		puts(v)	
  end
  end
end
