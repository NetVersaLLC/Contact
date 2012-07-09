class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string  :model
      t.string  :name
      t.text    :payload
      t.integer :location
      t.string  :status

      t.timestamps
    end
    add_index :payloads, :status
  end
end
