class AddSetupStatusFieldsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :setup_completed, :datetime, :default => nil
    add_column :businesses, :setup_msg_sent, :boolean, :default => false
  end
end
