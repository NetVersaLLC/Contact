class CreateIbeginCategories < ActiveRecord::Migration
  def change
    create_table :ibegin_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :ibegin_categories, :parent_id
    add_index :ibegin_categories, :name
     unless column_exists? :google_categories, :ibegin_category_id
      add_column :google_categories, :ibegin_category_id, :integer
    end
    unless column_exists? :ibegins, :ibegin_category_id
      add_column :ibegins, :ibegin_category_id, :integer
    end
  end
end
