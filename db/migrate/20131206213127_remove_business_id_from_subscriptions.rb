class RemoveBusinessIdFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :business_id
  end

  def down
    add_column :subscriptions, :business_id, :integer
  end
end
