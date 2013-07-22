class AddQueueInsertOrderToPackagepayloads < ActiveRecord::Migration
  def change
    add_column :package_payloads, :queue_insert_order, :integer, :default => 0
  end
end
