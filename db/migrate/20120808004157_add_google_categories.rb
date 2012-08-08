class AddGoogleCategories < ActiveRecord::Migration
  def change
    add_column :businesses, :category1, :string
    add_index  :businesses, :category1
    add_column :businesses, :category2, :string
    add_index  :businesses, :category2
    add_column :businesses, :category3, :string
    add_index  :businesses, :category3
  end
end
