namespace :snoopitnow do
  task :categories => :environment do
    root = SnoopitnowCategory.create(:name => 'root')
    File.open(Rails.root.join("categories", "Snoopitnow", "categories.txt"), 'r').each do |line|
      line.strip!
      STDERR.puts "Adding: #{line}"
      SnoopitnowCategory.create do |y|
        y.parent_id      = root.id
        y.name           = line
      end
    end
  end
end
