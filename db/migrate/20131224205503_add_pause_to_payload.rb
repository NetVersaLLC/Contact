class AddPauseToPayload < ActiveRecord::Migration
  def up
    add_column :payloads, :paused_at, :datetime
  end

  def down
    remove_column :payloads, :paused_at, :datetime
  end
end
