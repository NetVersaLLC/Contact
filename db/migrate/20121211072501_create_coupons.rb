class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :coupons, :code
    add_column :subscriptions, :coupon_id, :integer
  end
end
