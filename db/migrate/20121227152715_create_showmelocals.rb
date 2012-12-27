class CreateShowmelocals < ActiveRecord::Migration
  def change
    create_table :showmelocals do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :showmelocals, :business_id
  end
end
