class CreateMapQuests < ActiveRecord::Migration
  def change
    create_table :map_quests do |t|
      t.integer :business_id
      t.string :status

      t.timestamps
    end
    add_index :map_quests, :business_id
  end
end
