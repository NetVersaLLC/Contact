class CreateTwitters < ActiveRecord::Migration
  def change
    create_table :twitters do |t|
      t.integer  :business_id
      t.string   :username
      t.text     :secrets
      t.string   :status
      t.datetime :force_update

      t.timestamps
    end
  end
end
