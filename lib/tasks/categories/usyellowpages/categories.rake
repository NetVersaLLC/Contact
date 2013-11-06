namespace :usyellowpages do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Usyellowpages", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = UsyellowpagesCategory.create(:name => 'root')
    categories.each do |k| 
        node = UsyellowpagesCategory.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 