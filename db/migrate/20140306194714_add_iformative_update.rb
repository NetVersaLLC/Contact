class AddIformativeUpdate < ActiveRecord::Migration
  def up
    Payload.create(:site_id => 133, :name => "UpdateListing") 
  end

  def down
    Payload.where(:site_id => 133, :name => "UpdateListing").delete_all
  end
end
