class DropUnneededTables < ActiveRecord::Migration
  def up
  	drop_table :spotbusinesses
  	drop_table :spotbusiness_categories
  	drop_table :findthebests
  	drop_table :findthebest_categories
  	drop_table :findstorenearus  	


  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
