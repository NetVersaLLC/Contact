class AddingLabelToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :label_id, :integer
    add_column :labels,  :login,    :string
    add_column :labels,  :password, :string
  end
end
