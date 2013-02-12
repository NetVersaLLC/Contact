class AddLabelIdToPackagesPayloads < ActiveRecord::Migration
  def change
    add_column :packages, :label_id, :integer
    rename_table :packages_payloads, :package_payloads
  end
end
