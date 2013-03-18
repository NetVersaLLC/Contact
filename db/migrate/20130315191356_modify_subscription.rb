class ModifySubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :first_name
    remove_column :subscriptions, :last_name
    remove_column :subscriptions, :address
    remove_column :subscriptions, :city
    remove_column :subscriptions, :state
    remove_column :subscriptions, :zip
    remove_column :subscriptions, :authorizenet_code
    remove_column :subscriptions, :coupon_id
   # remove_column :subscriptions, :initial_fee
    remove_column :subscriptions, :transaction_code
    remove_column :subscriptions, :package_name
    remove_column :subscriptions, :total
    add_column :subscriptions, :response, :text
    add_column :subscriptions, :message, :string
    add_column :subscriptions, :name, :string
    add_column :subscriptions, :monthly_fee, :integer
    add_column :subscriptions, :subscription_number, :string
  end
end
