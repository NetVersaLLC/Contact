class AddStatusCreditEvent < ActiveRecord::Migration
  def change
    add_column :credit_events, :status, :string
  end
end
