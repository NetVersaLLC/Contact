class ChangeLocationToPosition < ActiveRecord::Migration
  def change
    rename_column :payloads, :location, :position
  end
end
