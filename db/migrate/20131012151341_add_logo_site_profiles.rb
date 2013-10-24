class AddLogoSiteProfiles < ActiveRecord::Migration
  def up
    add_attachment :sites, :logo
  end

  def down
    remove_attachment :sites, :logo
  end
end
