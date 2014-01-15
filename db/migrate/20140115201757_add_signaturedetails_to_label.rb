class AddSignaturedetailsToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :sales_phone, :string 
    add_column :labels, :sales_email, :string 
    add_column :labels, :website_url, :string 
    add_column :labels, :website_name, :string
  end
end
