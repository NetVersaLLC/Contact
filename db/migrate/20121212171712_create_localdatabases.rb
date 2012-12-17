class CreateLocaldatabases < ActiveRecord::Migration
  def change
    create_table :localdatabases do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
  end
end
