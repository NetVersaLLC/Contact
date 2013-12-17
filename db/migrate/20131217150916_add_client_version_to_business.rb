class AddClientVersionToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :client_version, :string, default: "0.0.0"
  end
end
