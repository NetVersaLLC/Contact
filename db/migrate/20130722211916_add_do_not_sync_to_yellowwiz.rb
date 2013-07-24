class AddDoNotSyncToYellowwiz < ActiveRecord::Migration
  def change
    add_column :yellowwizs, :do_not_sync, :boolean, :default => 0
  end
end
