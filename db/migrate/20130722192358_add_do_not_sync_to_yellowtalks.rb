class AddDoNotSyncToYellowtalks < ActiveRecord::Migration
  def change
    add_column :yellowtalks, :do_not_sync, :boolean, :default => 0
  end
end
