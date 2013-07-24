class AddBillingToTransactionevents < ActiveRecord::Migration
  def change
    add_column :credit_events, :charge_amount, :decimal, :precision => 8, :scale => 2, :default=>0.0
    add_column :credit_events, :post_available_balance, :decimal, :precision => 8, :scale => 2, :default=>0.0
    add_column :credit_events, :transaction_event_id, :integer
    add_column :labels, :available_balance, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end
end
