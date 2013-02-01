class AddCategory2ToZippro < ActiveRecord::Migration
  def change
    add_column :zippros, :zippro_category_id, :integer
  end
end
