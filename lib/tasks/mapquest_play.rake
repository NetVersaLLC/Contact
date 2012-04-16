namespace :contact do
  task :mapquest => :environment do
    data = { :username => 'jjeffus@gmail.com', :password => '1243' }
    c = CerebusClient.new
    enc = c.load data
    STDERR.puts enc
    #unenc = c.dump enc
    #Cerebus.decrypt enc, 
    #STDERR.puts unenc
    #m = MapQuest.new
    #m.secrets = data
    #m.user_id = 1
    #m.status = 'new'
    #m.save
  end
end
