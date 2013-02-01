class CreateSnoopitnows < ActiveRecord::Migration
  def change
    create_table :snoopitnows do |t|
      t.integer :business_id
      t.string :snoopitnow_category_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
