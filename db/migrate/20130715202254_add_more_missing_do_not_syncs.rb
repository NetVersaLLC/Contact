class AddMoreMissingDoNotSyncs < ActiveRecord::Migration
   def change
    unless column_exists? :localezes, :do_not_sync
  		add_column :localezes, :do_not_sync, :boolean, :default => 0
	end

  end
end
