namespace :yellowtalk do
  task :categories => :environment do
root = YellowtalkCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Yellowtalk", "categories.txt"), 'r').each do |line|
  next if line == ""
      YellowtalkCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end


=begin
require 'json'

namespace :yellowtalk do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Yellowtalk", "categories.json"), 'r').read
    categories = JSON.parse(body) 

	 root = YellowtalkCategory.create(:name => 'root')
 		categories.each_pair do |k,v| 
 			node = root.children.create(:name => k, :parent_id => root.id)  
  			puts(k)
  			v.each do |sub|
	   			puts(" > " + sub)
   				cat = node.children.create(:name => sub, :parent_id => node.id)
  		end   
 	end
  end
end
=end