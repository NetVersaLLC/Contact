class CreateYelps < ActiveRecord::Migration
  def change
    create_table :yelps do |t|
      t.integer  :business_id
      t.integer  :yelp_category_id
      t.string   :email
      t.text     :secrets
      t.string   :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :yelps, :business_id
  end
end
