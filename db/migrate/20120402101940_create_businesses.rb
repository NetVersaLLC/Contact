class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :user_id
      t.string :name
      t.string :contact
      t.string :phone
      t.string :alternate_phone
      t.string :fax
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :website
      t.string :email

      t.timestamps
    end
    add_index :businesses, :user_id
    add_index :businesses, :email
  end
end
