class AddDoNotSyncToOnlinenetworks < ActiveRecord::Migration
  def change
  	add_column :onlinenetworks, :do_not_sync, :boolean
  end
end
