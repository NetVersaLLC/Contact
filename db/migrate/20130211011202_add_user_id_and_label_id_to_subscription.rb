class AddUserIdAndLabelIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :label_id, :integer
    add_column :subscriptions, :business_id, :integer
  end
end
