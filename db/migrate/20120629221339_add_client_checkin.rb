class AddClientCheckin < ActiveRecord::Migration
  def change
    add_column :businesses, :client_checkin, :datetime
  end
end
