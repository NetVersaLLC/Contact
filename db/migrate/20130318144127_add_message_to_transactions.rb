class AddMessageToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :message, :string
    add_column :subscriptions, :status, :string
    remove_column :subscriptions, :name
    remove_column :subscriptions, :subscription_number
    remove_column :subscriptions, :phone
    remove_column :subscriptions, :address2
    remove_column :subscriptions, :affiliate_id
  end
end
