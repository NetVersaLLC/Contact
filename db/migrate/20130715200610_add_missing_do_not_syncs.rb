class AddMissingDoNotSyncs < ActiveRecord::Migration
   def change
    unless column_exists? :hotfrogs, :do_not_sync
  		add_column :hotfrogs, :do_not_sync, :boolean, :default => 0
	end
	unless column_exists? :mywebyellows, :do_not_sync
  		add_column :mywebyellows, :do_not_sync, :boolean, :default => 0
	end

  end
end
