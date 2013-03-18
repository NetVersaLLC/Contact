class MoveTransactionIdToTransactionEventId < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :transaction_id, :transaction_event_id
    rename_column :payments,      :transaction_id, :transaction_event_id
  end
end
