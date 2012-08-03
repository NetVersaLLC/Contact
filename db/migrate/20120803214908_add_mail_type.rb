class AddMailType < ActiveRecord::Migration
  def change
    add_column :businesses, :mail_type, :string
  end
end
