class ImportZips < ActiveRecord::Migration
  def up
    mysql=`which mysql`
    db = ActiveRecord::Base.configurations[Rails.env]
    STDERR.puts "#{mysql.strip} -u #{db['username']} -h #{db['host']} #{db['database']} < #{Rails.root.join('db', 'zips.sql')}"
    system "#{mysql.strip} -u #{db['username']} -h #{db['host']} #{db['database']} < #{Rails.root.join('db', 'zips.sql')}"
  end

  def down
  end
end
