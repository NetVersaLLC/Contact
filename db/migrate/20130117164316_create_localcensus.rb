class CreateLocalcensus < ActiveRecord::Migration
  def change
    create_table :localcensus do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.integer :localcensus_category_id

      t.timestamps
    end
  end
end
