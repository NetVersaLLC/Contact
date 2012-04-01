class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :job_id
      t.string :status
      t.string :message
      t.text :output

      t.timestamps
    end
    add_index :results, :job_id
    add_index :results, :status
  end
end
