class AddDoNotSyncToMycitybusinesses < ActiveRecord::Migration
  def change
    add_column :mycitybusinesses, :do_not_sync, :boolean
  end
end
