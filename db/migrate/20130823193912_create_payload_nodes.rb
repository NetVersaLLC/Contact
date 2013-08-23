class CreatePayloadNodes < ActiveRecord::Migration
  def change
    create_table :payload_nodes do |t|
      t.string :name
      t.boolean :active, :default => 0
      t.datetime :broken_at
      t.text :notes
      t.integer :parent_id, :default => 1
      t.integer :package_id, :default => 0
      t.integer :position, :default => 0

      t.timestamps
    end
    add_index :payload_nodes, :name
    add_index :payload_nodes, :parent_id
    add_index :payload_nodes, :package_id
  end
end
