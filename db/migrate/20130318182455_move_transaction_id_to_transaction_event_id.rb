class MoveTransactionIdToTransactionEventId < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :transaction_id,       :transaction_event_id
    add_column    :payments,      :transaction_event_id, :integer
  end
end
