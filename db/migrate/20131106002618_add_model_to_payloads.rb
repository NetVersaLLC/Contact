class AddModelToPayloads < ActiveRecord::Migration
  def change
    add_column :sites, :model, :string
    add_index :sites, :model
  end
end
