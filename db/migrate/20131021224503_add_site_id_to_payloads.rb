class AddSiteIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :site_id, :integer
    add_index :payloads, :site_id
    remove_column :package_payloads, :site
    remove_column :package_payloads, :payload
    remove_column :package_payloads, :description
    add_column :package_payloads, :site_id, :integer
  end
end
