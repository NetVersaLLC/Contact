class CreateEzlocalCategories < ActiveRecord::Migration
  def change
    create_table :ezlocal_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :ezlocal_categories, :parent_id
    add_index :ezlocal_categories, :name
    add_column :google_categories, :ezlocal_category_id, :integer
  end
end
