class CreateGetfavs < ActiveRecord::Migration
  def change
    create_table :getfavs do |t|
      t.datetime :force_update
      t.text :secrets
      t.string :email
      t.integer :business_id

      t.timestamps
    end
    add_index :getfavs, :business_id
  end
end
