class CreateMeetlocalbizs < ActiveRecord::Migration
  def change
    create_table :meetlocalbizs do |t|
      t.integer :business_id
      t.text :username
      t.text :email
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
