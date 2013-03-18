class RenameTransactionsToTransactionEvents < ActiveRecord::Migration
  def change
    rename_table :transactions, :transaction_events
  end
end
