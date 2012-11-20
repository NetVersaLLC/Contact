class CreateThumbtacks < ActiveRecord::Migration
  def change
    create_table :thumbtacks do |t|
      t.integer :business_id
      t.datetime :force_update
      t.text :secrets
      t.string :email
      t.timestamps
    end
    add_index :thumbtacks, :business_id
  end
end
