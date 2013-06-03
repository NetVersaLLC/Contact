class AddPackageIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :ident, :string
    add_column :reports, :package_id, :integer
    add_index  :reports, :ident
  end
end
