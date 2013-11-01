require 'json'

namespace :staylocal do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Staylocal", "categories.json"), 'r').read
    categories = JSON.parse(body) 
root = StaylocalCategory.create(:name => "root")		
	categories.each do |v|	
		sub = root.children.create(:name => v)
		puts(v)	
  	end
  end
end
