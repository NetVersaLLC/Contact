namespace :data do
  task :generator, [:business_id, :name]  => :environment do |t,args|
    STDERR.puts "Examining: #{args[:name]}"
    business = Business.find( args[:business_id] )
    payload = Payload.start(args[:name])
    if payload.data_generator.nil?
      STDERR.puts "Data Generator is nil"
    else
      ap eval payload.data_generator
    end
  end
end
