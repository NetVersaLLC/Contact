class FixMapquest < ActiveRecord::Migration
  def change
    add_column :map_quests, :secrets, :text
    add_column :map_quests, :user_id, :integer
  end
end
