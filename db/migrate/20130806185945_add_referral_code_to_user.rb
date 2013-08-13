class AddReferralCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :referrer_code, :string
  end
end
