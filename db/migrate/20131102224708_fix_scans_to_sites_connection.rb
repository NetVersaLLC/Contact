class FixScansToSitesConnection < ActiveRecord::Migration
  def up
    rename_column :scans, :site_profile_id, :site_id
    rename_column :scans, :site, :site_name
  end

  def down
    rename_column :scans, :site_id, :site_profile_id
    rename_column :scans, :site_name, :site
  end
end
