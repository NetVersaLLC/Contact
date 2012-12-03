class CreateBusinesscoms < ActiveRecord::Migration
  def change
    create_table :businesscoms do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email

      t.timestamps
    end
    add_index :businesscoms, :business_id
  end
end
