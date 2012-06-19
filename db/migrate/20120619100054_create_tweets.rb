class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :business_id
      t.string :message

      t.timestamps
    end
    add_index :tweets, :business_id
  end
end
