class CreateCylexes < ActiveRecord::Migration
  def change
    create_table :cylexes do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email
      t.datetime :created_at

      t.timestamps
    end
    add_index :cylexes, :business_id
  end
end
