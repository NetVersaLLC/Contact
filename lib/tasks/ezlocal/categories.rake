namespace :ezlocal do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Ezlocal", "categories.txt"), 'r').each do |line|
      EzlocalCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
    end
  end
end
