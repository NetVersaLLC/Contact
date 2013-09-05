class AddPauseToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :paused_at, :datetime
  end
end
