class CreateYellowees < ActiveRecord::Migration
  def change
    create_table :yellowees do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :yellowees, :business_id
  end
end
