class CreateGomylocalCategories < ActiveRecord::Migration
  def change
    create_table :gomylocal_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :gomylocal_categories, :parent_id
    add_index :gomylocal_categories, :name
    unless column_exists? :google_categories, :gomylocal_category_id
      add_column :google_categories, :gomylocal_category_id, :integer
    end
    
    unless column_exists? :gomylocals, :gomylocal_category_id
      add_column :gomylocals, :gomylocal_category_id, :integer
  	end
  end
end
