class AddConnectionType < ActiveRecord::Migration
  def change
    add_column :accounts, :connection_type, :string
  end
end
