class AddSubscriptionIdToBusinessEdits < ActiveRecord::Migration
  def change
    add_column :business_form_edits, :subscription_id, :integer
  end
end
