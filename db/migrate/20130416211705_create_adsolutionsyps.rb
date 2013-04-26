class CreateAdsolutionsyps < ActiveRecord::Migration
  def change
    create_table :adsolutionsyps do |t|
      t.integer :business_id
      t.string :email
      t.string :secret_answer
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
