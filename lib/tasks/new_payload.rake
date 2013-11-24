require 'json'

namespace :bizhyw do
  task :categories => :environment do
    body = File.open(Rails.root.join("categories", "Bizhyw", "categories.json"), 'r').read
    categories = JSON.parse(body) 
    root = BizhywCategory.create(:name => 'root')
    categories.each_pair do |category,subcategories|
      node = BizhywCategory.create(:name => category, :parent_id => root.id)  
      puts category
      subcategories.each do |sub|
        puts " > " + sub
        cat = node.children.create(:name => sub, :parent_id => node.id)
      end
    end
  end
end
