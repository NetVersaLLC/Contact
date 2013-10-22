class SiteProfilesToSites < ActiveRecord::Migration
  def change
    rename_table :site_profiles, :sites
    rename_column :sites, :site, :name
    add_index :sites, :name
    rename_column :sites, :url, :domain
    add_column :sites, :login_url, :string
  end
end
