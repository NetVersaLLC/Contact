class RemoveParentIdDefaultValuePayload < ActiveRecord::Migration
  def up
    change_column_default(:payloads, :parent_id, nil)
  end

  def down
    change_column_default(:payloads, :parent_id, 1)
  end
end
