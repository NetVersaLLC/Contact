namespace :ebusinesspage do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Ebusinesspages", "final_list.txt"), 'r').each do |line|
      EbusinesspageCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
