class AddDoNotSyncToMycitybusinesses < ActiveRecord::Migration
  def change
    add_column :mycitybusinesses, :do_not_sync, :boolean, :default => 0
  end
end
