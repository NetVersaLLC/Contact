class CreateCitisquares < ActiveRecord::Migration
  def change
    create_table :citisquares do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email

      t.timestamps
    end
    add_index :citisquares, :business_id
  end
end
