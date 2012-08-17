class RemoveElements < ActiveRecord::Migration
  def change
    remove_column :businesses, :incentive_offers
    remove_column :businesses, :links_to_photos
    remove_column :businesses, :links_to_videos
    remove_column :businesses, :other_social_links
    remove_column :businesses, :positive_review_links
    remove_column :businesses, :services_offered
    remove_column :businesses, :specialies
    remove_column :businesses, :languages
    rename_column :businesses, :mail_password, :mail_pass
  end
end
