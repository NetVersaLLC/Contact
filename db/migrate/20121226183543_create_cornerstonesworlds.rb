class CreateCornerstonesworlds < ActiveRecord::Migration
  def change
    create_table :cornerstonesworlds do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :cornerstonesworlds, :business_id
  end
end
