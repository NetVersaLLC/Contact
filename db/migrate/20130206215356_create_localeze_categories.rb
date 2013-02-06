class CreateLocalezeCategories < ActiveRecord::Migration
  def change
    create_table :localeze_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :localeze_categories, :parent_id
    add_index :localeze_categories, :name
    
    unless column_exists? :google_categories, :localeze_category_id
      add_column :google_categories, :localeze_category_id, :integer
    end
    unless column_exists? :localezes, :localeze_category_id
      add_column :localezes, :localeze_category_id, :integer
    end
  end
end
