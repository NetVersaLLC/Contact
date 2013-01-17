class CreateEbusinesspages < ActiveRecord::Migration
  def change
    create_table :ebusinesspages do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.integer :ebusinesspage_category_id

      t.timestamps
    end
  end
end
