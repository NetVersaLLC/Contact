class CreatePayloadCategories < ActiveRecord::Migration
  def change
    create_table :payload_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
