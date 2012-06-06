class CreateHotfrogs < ActiveRecord::Migration
  def change
    create_table :hotfrogs do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.string :status
      t.datetime :force_update
      t.string :listing_url

      t.timestamps
    end
    add_index :hotfrogs, :business_id
  end
end
