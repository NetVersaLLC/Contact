class AddCategoryToZippro < ActiveRecord::Migration
  def change
    add_column :zippros, :zippro_category2_id, :integer
  end
end
