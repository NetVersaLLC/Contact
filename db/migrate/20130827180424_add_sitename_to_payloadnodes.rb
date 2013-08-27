class AddSitenameToPayloadnodes < ActiveRecord::Migration
  def change
    rename_column :payload_nodes, :name, :payload_name
    add_column :payload_nodes, :site_name, :string
  end
end
