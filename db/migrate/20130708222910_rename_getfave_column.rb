class RenameGetfaveColumn < ActiveRecord::Migration
  def up
  	rename_table :getfavs, :getfaves
  end

  def down
  	rename_table :getfaves, :getfavs 
  end
end
