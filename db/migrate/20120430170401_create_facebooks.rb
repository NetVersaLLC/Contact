class CreateFacebooks < ActiveRecord::Migration
  def change
    create_table :facebooks do |t|
      t.integer  :business_id
      t.string   :email
      t.text     :secrets
      t.string   :status
      t.datetime :force_update
      t.timestamps
    end
  end
end
