class CreateRewards < ActiveRecord::Migration
  def up
    create_table :rewards do |t| 
      t.integer    :points, default: 0
      t.references :administrator
      t.timestamps
    end 
  end

  def down
    drop_table :rewards
  end
end
