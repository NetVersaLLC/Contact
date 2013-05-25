class RemoveZipFromScans < ActiveRecord::Migration
  def change
    remove_column :scans, :listed_zip
  end
end
