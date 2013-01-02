class CreateHyplos < ActiveRecord::Migration
  def change
    create_table :hyplos do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :hyplos, :business_id
  end
end
