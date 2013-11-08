class RenameExpressbusinessdirectorie < ActiveRecord::Migration
  def up
    execute <<-SQL 
      update client_data set type='Expressbusinessdirectory' where type = 'Expressbusinessdirectorie'
    SQL
  end

  def down
  end
end
