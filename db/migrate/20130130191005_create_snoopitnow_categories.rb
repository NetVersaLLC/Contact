class CreateSnoopitnowCategories < ActiveRecord::Migration
  def change
    create_table :snoopitnow_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
  end
end
