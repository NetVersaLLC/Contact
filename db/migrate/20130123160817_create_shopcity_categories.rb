class CreateShopcityCategories < ActiveRecord::Migration
  def change
    create_table :shopcity_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :shopcity_categories, :parent_id
    add_index :shopcity_categories, :name
	unless column_exists? :google_categories, :shopcity_category_id
		add_column :google_categories, :shopcity_category_id, :integer
  end
  end
end
