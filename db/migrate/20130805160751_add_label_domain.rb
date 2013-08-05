class AddLabelDomain < ActiveRecord::Migration
  def change
    add_column :labels, :label_domain, :string
    add_column :labels, :address, :string
    add_column :labels, :legal_name, :string
    add_column :labels, :support_email, :string
    add_column :labels, :support_phone, :string
  end
end
