class AddEmailToEzlocal < ActiveRecord::Migration
  def change
    add_column :ezlocals, :email, :string
  end
end
