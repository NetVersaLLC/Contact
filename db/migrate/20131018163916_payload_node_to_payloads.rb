class PayloadNodeToPayloads < ActiveRecord::Migration
  def change
    rename_table :payload_nodes, :payloads
    add_column :payloads, :data_generator, :text
    add_column :payloads, :client_script, :text
    add_column :payloads, :ready, :text
  end
end
