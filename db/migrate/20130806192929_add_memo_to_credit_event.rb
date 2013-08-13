class AddMemoToCreditEvent < ActiveRecord::Migration
  def change
    add_column :credit_events, :memo, :string
  end
end
