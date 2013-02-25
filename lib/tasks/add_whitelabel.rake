namespace :add do
  task :whitelabel => :environment do
    user = User.find(ENV['user_id'])
    name = ENV['name']
    label = Label.create do |l|
      l.name = name
    end
    user.label_id = label.id
    user.save
  end
end
