class CreateSubscriptions < ActiveRecord::Migration
  def change
    add_column :businesses, :subscription_id, :integer
    create_table :subscriptions do |t|
      t.integer :affiliate_id
      t.integer :package_id
      t.string :package_name
      t.integer :total
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.boolean :tos_agreed
      t.boolean :active
      t.string :authorizenet_code

      t.timestamps
    end
    add_index :subscriptions, :package_id
    add_index :subscriptions, :affiliate_id
  end
end
