class AddStiClientData < ActiveRecord::Migration
  def up
    create_table :client_data do |t|
      t.string   :email 
      t.string   :username
      t.text     :secrets
      t.string   :status
      t.datetime :force_update
      t.boolean  :do_not_sync,        :default => false

      t.string   :secret_answer

      t.string   :local_url
      t.string   :listings_url
      t.string   :listing_url # insider pages, judys books, kudzus, ....
      t.string   :facebook_signin  #city searches, foursquares 
      t.string   :foursquare_page
      
      t.string   :places_url
      t.string   :youtube_channel
      t.text     :cookies

      t.string    :type

      t.timestamps

      t.references :profile_category # facebooks profile category id
      t.references :category
      t.references :business
    end
  end

  def down
    drop_table :client_data 
  end 
end