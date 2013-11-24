require 'json'

namespace :nsphere do
  task :categories => :environment do
    body = File.open(Rails.root.join("categories", "Nsphere", "categories.json"), 'r').read
    categories = JSON.parse(body) 
    root = NsphereCategory.create(:name => 'root')
    categories.each do |category|
      node = NsphereCategory.create(:name => category, :parent_id => root.id)  
      puts category
    end
  end
end
