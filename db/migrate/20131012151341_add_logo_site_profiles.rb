class AddLogoSiteProfiles < ActiveRecord::Migration
  def up
    add_attachment :site_profiles, :logo
  end

  def down
    remove_attachment :site_profiles, :logo
  end
end
