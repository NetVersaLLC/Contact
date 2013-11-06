namespace :supermedia do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "Supermedia", "final_list.txt"), 'r').each do |line|
	next if line == ""
      SupermediaCategory.create do |y|
        y.parent_id      = 0
        y.name           = line        
      end
      puts(line)
    end
  end
end
