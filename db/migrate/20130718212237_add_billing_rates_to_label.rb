class AddBillingRatesToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :package_signup_rate, :decimal, :precision => 8, :scale => 2, :default => 0.0 
    add_column :labels, :package_subscription_rate, :decimal, :precision => 8, :scale => 2, :default => 0.0 
    add_column :labels, :credit_limit, :decimal, :precision => 8, :scale => 2, :default => 0.0 
  end
end
