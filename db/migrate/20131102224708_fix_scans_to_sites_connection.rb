class FixScansToSitesConnection < ActiveRecord::Migration
  def up
    rename_column :scans, :site_profile_id, :site_id
  end

  def down
    rename_column :scans, :site_id, :site_profile_id
  end
end
