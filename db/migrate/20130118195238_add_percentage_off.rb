class AddPercentageOff < ActiveRecord::Migration
  def change
    add_column :coupons, :percentage_off, :integer
    add_column :packages, :monthly_fee, :integer
    add_column :subscriptions, :intial_fee, :integer
  end
end
