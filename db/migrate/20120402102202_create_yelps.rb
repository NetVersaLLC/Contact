class CreateYelps < ActiveRecord::Migration
  def change
    create_table :yelps do |t|
      t.integer :business_id
      t.string :cat
      t.string :subcat

      t.timestamps
    end
    add_index :yelps, :business_id
  end
end
