class CreateTupaloCategories < ActiveRecord::Migration
  def change
    create_table :tupalo_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :tupalo_categories, :parent_id
    add_index :tupalo_categories, :name
    unless column_exists? :google_categories, :tupalo_category_id
      add_column :google_categories, :tupalo_category_id, :integer
    end    
    unless column_exists? :tupalos, :tupalo_category_id
      add_column :tupalos, :tupalo_category_id, :integer
  	end
  end
end
