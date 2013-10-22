class AddSiteprofileReferenceScan < ActiveRecord::Migration
  def change
    add_column :scans, :site_profile_id, :integer
  end
end
