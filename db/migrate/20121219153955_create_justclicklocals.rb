class CreateJustclicklocals < ActiveRecord::Migration
  def change
    create_table :justclicklocals do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :justclicklocals, :business_id
  end
end
