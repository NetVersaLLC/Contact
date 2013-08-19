class AddDoNotSyncToMeetlocalbizs < ActiveRecord::Migration
  def change
  	add_column :meetlocalbizs, :do_not_sync, :boolean
  end
end
