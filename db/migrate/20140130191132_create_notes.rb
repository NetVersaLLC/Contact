class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t| 
      t.string   :body 
      t.integer  :user_id

      t.references :business
      t.timestamps
    end 
  end

  def down
    drop_table :notes
  end
end
