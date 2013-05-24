class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :site
      t.string :business
      t.string :phone
      t.string :zip
      t.string :status
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :business_id

      t.timestamps
    end
    add_index :reports, :business_id
  end
end
