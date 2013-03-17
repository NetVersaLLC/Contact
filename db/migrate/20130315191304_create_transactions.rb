class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :subscription_id
      t.integer :payment_id
      t.string :status
      t.integer :business_id
      t.integer :label_id
      t.integer :coupon_id
      t.integer :package_id
      t.integer :price
      t.integer :original_price
      t.integer :monthly_fee
      t.integer :saved

      t.timestamps
    end
    add_index :transactions, :subscription_id
    add_index :transactions, :payment_id
    add_index :transactions, :business_id
    add_index :transactions, :label_id
    add_index :transactions, :coupon_id
    add_index :transactions, :package_id
  end
end
