class CreateBooboos < ActiveRecord::Migration
  def change
    create_table :booboos do |t|
      t.integer :user_id
      t.integer :business_id
      t.text :message
      t.string :ip
      t.string :user_agent

      t.timestamps
    end
    add_index :booboos, :user_id
    add_index :booboos, :business_id
  end
end
