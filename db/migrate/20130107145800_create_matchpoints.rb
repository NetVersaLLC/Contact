class CreateMatchpoints < ActiveRecord::Migration
  def change
    create_table :matchpoints do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :matchpoints, :business_id
  end
end
