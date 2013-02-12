class CreateMatchpointCategories < ActiveRecord::Migration
  def change
    create_table :matchpoint_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :matchpoint_categories, :parent_id
    add_index :matchpoint_categories, :name
  end
end
