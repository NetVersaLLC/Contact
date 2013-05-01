class UpdateYahooCategoryTable < ActiveRecord::Migration
  def up
  	remove_column :yahoo_categories, :rcatid, :catname, :subcatid, :subcatname, :subprofcontact, :synonyms
  	add_column :yahoo_categories, :parent_id, :integer
  	add_column :yahoo_categories, :name, :string
  	add_index :yahoo_categories, :parent_id
    add_index :yahoo_categories, :name
      
  end

  def down

	remove_index :yahoo_categories, :parent_id
    remove_index :yahoo_categories, :name
    remove_column :yahoo_categories, :parent_id, :name
  	add_column :yahoo_categories, :rcatid, :integer
  	add_column :yahoo_categories, :catname, :string
  	add_column :yahoo_categories, :subcatid, :integer
  	add_column :yahoo_categories, :subcatname, :string
  	add_column :yahoo_categories, :subprofcontact, :boolean
  	add_column :yahoo_categories, :synonyms, :string
  	
  end
end
