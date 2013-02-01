require 'json'

namespace :expertfocus do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Expertfocus", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	categories.each do |v|	
	root = ExpertfocusCategory.create(:name => v)		
		puts(v)	
  end
  end
end
