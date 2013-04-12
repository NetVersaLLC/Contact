class CreateUscityCategories < ActiveRecord::Migration
  def change
    create_table :uscity_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :uscity_categories, :parent_id
    add_index :uscity_categories, :name
    unless column_exists? :google_categories, :uscity_category_id
      add_column :google_categories, :uscity_category_id, :integer
    end    
    unless column_exists? :uscities, :uscity_category_id
      add_column :uscities, :uscity_category_id, :integer
  	end
  end
end
