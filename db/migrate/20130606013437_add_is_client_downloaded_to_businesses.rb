class AddIsClientDownloadedToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :is_client_downloaded, :boolean, :default => false
  end
end
