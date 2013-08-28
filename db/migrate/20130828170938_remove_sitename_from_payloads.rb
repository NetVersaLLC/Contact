class RemoveSitenameFromPayloads < ActiveRecord::Migration
  def change
    remove_column :payload_nodes, :site_name
    rename_column :payload_nodes, :payload_name, :name
  end

end
