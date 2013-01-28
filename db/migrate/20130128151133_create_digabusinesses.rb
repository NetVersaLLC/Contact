class CreateDigabusinesses < ActiveRecord::Migration
  def change
    create_table :digabusinesses do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
