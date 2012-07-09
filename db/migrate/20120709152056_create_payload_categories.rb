class CreatePayloadCategories < ActiveRecord::Migration
  def change
    create_table :payload_categories do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end
    add_column :payloads, :payload_category_id, :integer
    add_index :payloads, :payload_category_id
  end
end
