class AddScanTable < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.integer :report_id
      t.string :site
      t.string :business
      t.string :phone
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.string :state
      t.string :state_short
      t.string :city
      t.string :county
      t.string :country
      t.string :status
      t.string :listed_phone
      t.string :listed_address
      t.string :listed_zip
      t.integer :request_time
      t.text   :error_message
    end
    add_index :scans, :site
    add_index :scans, :business
    add_index :scans, :phone
    add_index :scans, :zip
  end
end
