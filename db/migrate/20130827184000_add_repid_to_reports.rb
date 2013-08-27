class AddRepidToReports < ActiveRecord::Migration
  def change
    add_column :reports, :referrer_code, :string
  end
end
