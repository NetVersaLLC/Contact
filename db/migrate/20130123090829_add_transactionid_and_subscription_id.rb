class AddTransactionidAndSubscriptionId < ActiveRecord::Migration
  def change
    add_column :subscriptions, :transaction_code, :string
    add_column :subscriptions, :subscription_code, :string
  end
end
