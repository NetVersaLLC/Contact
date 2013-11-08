class RenameLocalpage < ActiveRecord::Migration
  def up
    execute <<-SQL 
      update client_data set type='Localpages' where type = 'Localpage'
    SQL
  end

  def down
  end
end
