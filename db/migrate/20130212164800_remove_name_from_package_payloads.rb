class RemoveNameFromPackagePayloads < ActiveRecord::Migration
  def change
    remove_column :package_payloads, :name
  end
end
