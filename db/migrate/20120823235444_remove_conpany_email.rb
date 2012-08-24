class RemoveConpanyEmail < ActiveRecord::Migration
  def change
    remove_column :businesses, :company_email
  end
end
