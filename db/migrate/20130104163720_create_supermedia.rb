class CreateSupermedia < ActiveRecord::Migration
  def change
    create_table :supermedia do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :supermedia, :business_id
  end
end
