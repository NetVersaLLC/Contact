class CreateModes < ActiveRecord::Migration
  def change
    create_table :modes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_column :businesses, :mode_id, :integer
    add_index :businesses, :mode_id
    add_column :payloads, :mode_id, :integer, :default => 1
    add_index :payloads, :mode_id
  end
end
