class AddTransactionIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :transaction_id, :integer
  end
end
