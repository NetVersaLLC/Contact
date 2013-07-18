class CreateYellowwizs < ActiveRecord::Migration
  def change
    create_table :yellowwizs do |t|
      t.integer :business_id
      t.string :email
      t.string :username
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
