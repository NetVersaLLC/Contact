class CreateBrownbooks < ActiveRecord::Migration
  def change
    create_table :brownbooks do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.string :email

      t.timestamps
    end
    add_index :brownbooks, :business_id
  end
end
