class AddHeapToClientData < ActiveRecord::Migration
  def change
    add_column :client_data, :heap, :string, :default => '{}'
  end
end
