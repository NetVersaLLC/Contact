class AddCategoriesToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :category4, :string
    add_column :businesses, :category5, :string
  end
end
