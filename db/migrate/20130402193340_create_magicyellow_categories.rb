class CreateMagicyellowCategories < ActiveRecord::Migration
  def change
    create_table :magicyellow_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :magicyellow_categories, :parent_id
    add_index :magicyellow_categories, :name
    unless column_exists? :google_categories, :magicyellow_category_id
      add_column :google_categories, :magicyellow_category_id, :integer
    end    
    unless column_exists? :magicyellows, :magicyellow_category_id
      add_column :magicyellows, :magicyellow_category_id, :integer
  	end
  end
end
