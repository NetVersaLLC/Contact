class CreateEzlocals < ActiveRecord::Migration
  def change
    create_table :ezlocals do |t|
      t.integer  :business_id
      t.datetime :force_update
      t.text     :secrets
      t.integer :ezlocal_category_id
      t.timestamps
    end
  end
end
