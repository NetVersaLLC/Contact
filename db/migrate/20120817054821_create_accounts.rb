class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer  :business_id
      t.string   :email
      t.string   :username
      t.integer  :port
      t.string   :address
      t.text     :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :accounts, :business_id
    add_index :accounts, :email
  end
end
