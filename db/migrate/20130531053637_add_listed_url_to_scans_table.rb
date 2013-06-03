class AddListedUrlToScansTable < ActiveRecord::Migration
  def change
    add_column :scans, :listed_url, :string
    add_column :scans, :completed_at, :datetime
    remove_column :reports, :name
    remove_column :reports, :started_at
  end
end
