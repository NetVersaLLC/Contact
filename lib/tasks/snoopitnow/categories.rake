namespace :snoopitnow do
  task :categories => :environment do
    root = LocalcensusCategory.create(:name => 'root')
    File.open(Rails.root.join("categories", "Snoopitnow", "categories.txt"), 'r').each do |line|
      line.strip!
      SnoopitnowCategory.create do |y|
        y.parent_id      = root.id
        y.name           = line
      end
    end
    STDERR.puts "Adding: #{line}"
  end
end
