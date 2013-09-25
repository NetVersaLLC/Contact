class AddEnabledForSiteProfiles < ActiveRecord::Migration
  def change
    add_column :site_profiles, :enabled, :boolean, :default => true
    add_column :site_profiles, :technical_notes, :text
  end
end
