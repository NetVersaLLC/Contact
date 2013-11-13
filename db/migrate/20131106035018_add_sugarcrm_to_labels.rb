class AddSugarcrmToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :crm_url, :string
    add_column :labels, :crm_username, :string
    add_column :labels, :crm_password, :string
  end
end
