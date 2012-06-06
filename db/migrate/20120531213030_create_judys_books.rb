class CreateJudysBooks < ActiveRecord::Migration
  def change
    create_table :judys_books do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.string :status
      t.boolean :facebook_signin
      t.datetime :force_update
      t.string :listing_url

      t.timestamps
    end
    add_index :judys_books, :business_id
  end
end
