class CreateCitydata < ActiveRecord::Migration
  def change
    create_table :citydata do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.datetime :force_update
      t.boolean :do_not_sync
      t.integer :citydata_category_id
      t.timestamps
    end
  end
end
