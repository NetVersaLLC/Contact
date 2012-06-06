class CreateGoogles < ActiveRecord::Migration
  def change
    create_table :googles do |t|
      t.integer :business_id
      t.string :email
      t.string :youtube_channel
      t.string :places_url
      t.text :secrets
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :googles, :business_id
  end
end
