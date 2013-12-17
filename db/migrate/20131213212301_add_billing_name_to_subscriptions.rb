class AddBillingNameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :billing_name, :string
  end
end
