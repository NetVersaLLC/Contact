class AddEmailToReports < ActiveRecord::Migration
  def change
    add_column :reports, :email, :string
    add_column :reports, :email_sent, :datetime
  end
end
