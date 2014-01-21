class AddSalespersonidToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :salesperson_id, :integer
  end
end
