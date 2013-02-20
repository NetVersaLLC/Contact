class RemovePayloadCategory < ActiveRecord::Migration
  def change
    # drop_table :payload_categories
    #drop_table :pings
    # drop_table :refinery_images
    # drop_table :refinery_page_parts
    # drop_table :refinery_pages
    drop_table :results
    drop_table :roles
    drop_table :roles_users
    drop_table :seo_meta
    drop_table :tasks
    drop_table :user_plugins
  end
end
