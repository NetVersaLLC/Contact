class CreateStaylocals < ActiveRecord::Migration
  def change
    create_table :staylocals do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email
      t.datetime :created_at

      t.timestamps
    end
    add_index :staylocals, :business_id
  end
end
