class AddCategoryToPrimeplace < ActiveRecord::Migration
  def change
    add_column :primeplaces, :primeplace_category_id, :integer
  end
end
