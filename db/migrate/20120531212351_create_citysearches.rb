class CreateCitysearches < ActiveRecord::Migration
  def change
    create_table :citysearches do |t|
      t.integer :business_id
      t.string :email
      t.string :listing_url
      t.boolean :facebook_signin
      t.text :secrets
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :citysearches, :business_id
  end
end
