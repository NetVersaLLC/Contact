class ChangeNameToFirstLastOnSubscription < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :name, :first_name
    add_column :subscriptions, :last_name, :string
  end
end
