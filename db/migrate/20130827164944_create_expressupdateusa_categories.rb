class CreateExpressupdateusaCategories < ActiveRecord::Migration
  def change
    create_table :expressupdateusa_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :expressupdateusa_categories, :parent_id
    add_column :expressupdateusas, :expressupdateusa_category_id, :integer
  end
end
