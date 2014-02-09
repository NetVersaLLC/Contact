class AddCallcenteridToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :call_center_id, :integer

    add_index :businesses, :call_center_id
  end
end
