class AddTransactionCodeToCreditevents < ActiveRecord::Migration
  def change
    add_column :credit_events, :transaction_code, :string
    add_index :credit_events, :label_id 
  end
end
