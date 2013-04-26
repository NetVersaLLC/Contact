class CreateUsyellowpagesCategories < ActiveRecord::Migration
  def change
    create_table :usyellowpages_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :usyellowpages_categories, :parent_id
    add_index :usyellowpages_categories, :name
    unless column_exists? :google_categories, :usyellowpages_category_id
      add_column :google_categories, :usyellowpages_category_id, :integer
    end    
    unless column_exists? :usyellowpages, :usyellowpages_category_id
      add_column :usyellowpages, :usyellowpages_category_id, :integer
    end
  end
end
