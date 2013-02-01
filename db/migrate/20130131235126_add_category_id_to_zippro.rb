class AddCategoryIdToZippro < ActiveRecord::Migration
  def change
    add_column :zippros, :form_id, :integer
  end
end
