class CreateMapQuests < ActiveRecord::Migration
  def change
    create_table :map_quests do |t|
      t.integer  :business_id
      t.string   :email
      t.text     :secrets
      t.string   :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :map_quests, :business_id
  end
end
