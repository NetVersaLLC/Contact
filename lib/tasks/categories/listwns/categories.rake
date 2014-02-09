namespace :listwns do
  task :categories => :environment do
root = ListwnsCategory.create(:name => 'root')  
  File.open(Rails.root.join("categories", "Listwns", "categories.txt"), 'r').each do |line|
    next if line == ""
      line.chomp
      ListwnsCategory.create( :name => line, :parent_id => root.id)      
      puts(line)           
    end
  end
end
 