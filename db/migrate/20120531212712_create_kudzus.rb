class CreateKudzus < ActiveRecord::Migration
  def change
    create_table :kudzus do |t|
      t.integer :business_id
      t.string :username
      t.text :secrets
      t.string :listing_url
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :kudzus, :business_id
  end
end
