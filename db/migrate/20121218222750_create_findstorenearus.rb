class CreateFindstorenearus < ActiveRecord::Migration
  def change
    create_table :findstorenearus do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
	t.text :email

      t.timestamps
    end
    add_index :findstorenearus, :business_id
  end
end
