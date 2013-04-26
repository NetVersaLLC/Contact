require 'json'

namespace :spotbusiness do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Spotabusiness", "categories.json"), 'r').read
    categories = JSON.parse(body) 
root = SpotbusinessCategory.create(:name => "root")		
	categories.each do |v|	
		sub = root.children.create(:name => v)
		puts(v)	
  	end
  end
end
