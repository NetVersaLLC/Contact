class AddBusinessFormEditToImage < ActiveRecord::Migration
  def change
    add_column :images, :business_form_edit_id, :integer 
  end
end
