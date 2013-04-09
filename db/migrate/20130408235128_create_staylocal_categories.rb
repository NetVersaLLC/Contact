class CreateStaylocalCategories < ActiveRecord::Migration
  def change
    create_table :staylocal_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :staylocal_categories, :parent_id
    add_index :staylocal_categories, :name
     unless column_exists? :google_categories, :staylocal_category_id
      add_column :google_categories, :staylocal_category_id, :integer
    end    
    unless column_exists? :staylocals, :staylocal_category_id
      add_column :staylocals, :staylocal_category_id, :integer
  	end
  end
end
