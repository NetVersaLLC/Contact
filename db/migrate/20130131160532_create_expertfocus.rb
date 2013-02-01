class CreateExpertfocus < ActiveRecord::Migration
  def change
    create_table :expertfocus do |t|
      t.integer :business_id
      t.string :expertfocus_category_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
