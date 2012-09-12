class CreateYellowBots < ActiveRecord::Migration
  def change
    create_table :yellow_bots do |t|
      t.string :username
      t.string :email
      t.datetime :force_update

      t.timestamps
    end
  end
end
