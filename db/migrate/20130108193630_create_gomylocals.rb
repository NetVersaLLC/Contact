class Gomylocal < ActiveRecord::Migration
  def change
    create_table :gomylocals do |t|
      t.integer :business_id
      t.datetime :force_update
      t.timestamps
    end
    add_index :gomylocals, :business_id
  end
end
