class CreateGomylocals < ActiveRecord::Migration
  def change
    create_table :gomylocals do |t|
      t.integer :business_id
      t.string :username
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
