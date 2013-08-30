class CreateByzlysts < ActiveRecord::Migration
  def change
    create_table :byzlysts do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :byzlysts, :parent_id
  end
end