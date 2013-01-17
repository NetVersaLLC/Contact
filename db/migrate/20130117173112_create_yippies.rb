class CreateYippies < ActiveRecord::Migration
  def change
    create_table :yippies do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.integer :yippie_category_id

      t.timestamps
    end
  end
end
