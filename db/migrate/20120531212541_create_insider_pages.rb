class CreateInsiderPages < ActiveRecord::Migration
  def change
    create_table :insider_pages do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.string :listing_url
      t.boolean :facebook_signin
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :insider_pages, :business_id
  end
end
