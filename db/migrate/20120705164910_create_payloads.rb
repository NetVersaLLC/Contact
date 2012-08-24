class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string  :model
      t.string  :name
      t.text    :payload
      t.integer :position

      t.timestamps
    end
    add_index :payloads, :name
  end
end
