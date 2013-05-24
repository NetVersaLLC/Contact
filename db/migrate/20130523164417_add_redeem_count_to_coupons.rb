class AddRedeemCountToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :redeemed_count, :integer, :default => 0
    add_column :coupons, :allowed_upto, :integer, :default => 0 
  end
end
