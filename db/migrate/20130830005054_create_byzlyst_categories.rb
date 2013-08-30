class CreateByzlystCategories < ActiveRecord::Migration
  def change
    create_table :byzlyst_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :byzlyst_categories, :parent_id
    add_column :byzlysts, :byzlyst_category_id, :integer
  end
end
