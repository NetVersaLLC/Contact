class AddSubscriptionCreditRelation < ActiveRecord::Migration
  def change 
    add_column :credit_events, :subscription_id, :integer
    add_column :subscriptions, :label_last_billed_at, :datetime, :default => 2.months.ago
  end
end
