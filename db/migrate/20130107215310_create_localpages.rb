class CreateLocalpages < ActiveRecord::Migration
  def change
    create_table :localpages do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :localpages, :business_id
  end
end
