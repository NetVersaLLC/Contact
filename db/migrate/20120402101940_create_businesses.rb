class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.integer :user_id
      t.string :email
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :contact
      t.string :toll_free_phone
      t.string :phone
      t.string :alternate_phone
      t.string :fax
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :website
      t.text   :short_description
      t.text   :long_description
      t.string :hours
      t.string :descriptive_keyword
      t.string :keywords
      t.boolean :approved

      t.timestamps
    end
    add_index :businesses, :user_id
    add_index :businesses, :email
  end
end
