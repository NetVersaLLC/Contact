require 'json'

namespace :matchpoint do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Matchpoint", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	categories.each do |v|	
	root = MatchpointCategory.create(:name => v)		
		puts(v)	
  end
  end
end
