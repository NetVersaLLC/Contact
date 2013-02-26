class CreateDiscoverourtowns < ActiveRecord::Migration
  def change
    create_table :discoverourtowns do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :discoverourtowns, :business_id
  end
end