class CreateSuperpages < ActiveRecord::Migration
  def change
    create_table :superpages do |t|
      t.integer :business_id
      t.datetime :force_update
      t.text :secrets
      t.string :email
      t.timestamps
    end
    add_index :superpages, :business_id
  end
end
