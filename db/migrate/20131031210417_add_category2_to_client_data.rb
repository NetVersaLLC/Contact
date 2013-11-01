class AddCategory2ToClientData < ActiveRecord::Migration
  def change
    add_column :client_data, :category2_id, :integer
  end
end
