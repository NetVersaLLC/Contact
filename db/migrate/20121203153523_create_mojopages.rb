class CreateMojopages < ActiveRecord::Migration
  def change
    create_table :mojopages do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email

      t.timestamps
    end
    add_index :mojopages, :business_id
  end
end
