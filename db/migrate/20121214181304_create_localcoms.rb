class CreateLocalcoms < ActiveRecord::Migration
  def change
    create_table :localcoms do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :localcoms, :business_id
  end
end
