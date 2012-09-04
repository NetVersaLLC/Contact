namespace :payloads do
  task :list_categories => :environment do
    i = 0
    PayloadCategory.order(:position).each do |p|
      i += 1
      puts "#{i}: #{p.position}: #{p.name}"
    end
  end
  task :add_category => :environment do
    category=ENV['category']
    if category.nil?
      STDERR.puts "Usage: rake payloads:add_category category=<categoryname>"
      exit
    end
    PayloadCategory.create do |p|
      p.name = category
      p.position = PayloadCategory.next_position
    end
    STDERR.puts "Added category: #{category}"
  end
  task :add => :environment do
    category = ENV['category']
    name     = ENV['name']
    payload  = ENV['payload']
    generator= ENV['generator']
    if category.nil? or name.nil? or payload.nil?
      STDERR.puts "Usage: rake payloads:add category=<categoryname> name=<name> payload=<file> [ generator=<data generator> ]"
      exit
    end
    cat = PayloadCategory.where(:name => name).first
    if cat.nil?
      STDERR.puts "Category not found! List with payloads:list_categories."
      exit
    end
    file = File.open(payload, "r").read
    STDERR.puts file
    STDERR.puts "Generator: '#{generator}'"
    STDERR.puts "Name     : '#{name}'"
    STDERR.puts "Category : (#{cat.id}): '#{cat.name}'"
    STDERR.print "Add?: [y/N]: "
    if gets.strip == 'y'
      Payload.create do |p|
        p.name                = name
        p.data_generator      = generator
        p.payload_category_id = cat.id
        p.paylaod             = file
      end
      STDERR.puts "Added..."
    else
      STDERR.puts "Exiting without add..."
      exit
    end
  end
end
