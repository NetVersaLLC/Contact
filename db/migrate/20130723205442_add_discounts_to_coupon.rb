class AddDiscountsToCoupon < ActiveRecord::Migration
  def change
    rename_column :coupons, :percentage_off, :percentage_off_monthly
    add_column :coupons, :percentage_off_signup, :integer, :default => 0
    add_column :coupons, :dollars_off_monthly, :integer, default: 0
    add_column :coupons, :dollars_off_signup, :integer, default: 0
    add_column :coupons, :use_discount, :string, default: 'percentage'
  end
end
