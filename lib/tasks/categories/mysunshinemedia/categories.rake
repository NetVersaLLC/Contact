namespace :mysunshinemedia do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Mysunshinemedia", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = MysunshinemediaCategory.create(:name => 'root')
    categories.each do |k| 
        node = root.children.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 
