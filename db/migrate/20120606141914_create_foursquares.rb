class CreateFoursquares < ActiveRecord::Migration
  def change
    create_table :foursquares do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.string :status
      t.boolean :facebook_signin
      t.datetime :force_update

      t.timestamps
    end
    add_index :foursquares, :business_id
  end
end
