class CreateYahoos < ActiveRecord::Migration
  def change
    create_table :yahoos do |t|
      t.integer :business_id
      t.integer :yahoo_category_id
      t.string :email
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :yahoos, :business_id
    add_index :yahoos, :yahoo_category_id
    add_index :yahoos, :email
  end
end
