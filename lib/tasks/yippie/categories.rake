namespace :yippie do
  task :categories => :environment do
    root = YippieCategory.create(:name => 'root')
      File.open(Rails.root.join("categories", "Yippie", "categories.txt"), 'r').each do |line|
      next if line == ""
          YippieCategory.create( :name => line, :parent_id => root.id)
          puts(line)
        end
  end
end
 