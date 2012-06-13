class ImportZips < ActiveRecord::Migration
  def up
    mysql=`which mysql`
    db = ActiveRecord::Base.configurations[Rails.env]
    STDERR.puts "#{mysql.strip} -u #{db['host']} -h #{db['hostname']} #{db['database']} < #{Rails.root.join('db', 'zips.sql')}"
  end

  def down
  end
end
