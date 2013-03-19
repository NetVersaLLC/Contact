class AddParentIdToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :parent_id, :integer
    add_column :labels, :credits, :integer, :default => 0
    add_column :labels, :mail_from, :string, :default => 'change_this@to_your_support_email.com'
  end
end
