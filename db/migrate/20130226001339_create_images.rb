class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :business_id
      t.integer :position
      t.string :file_name
      t.string :display_name
      t.integer :data_file_size
      t.string :data_file_name
      t.string :data_content_type
      t.datetime :data_updated_at
      t.integer :width
      t.integer :height

      t.timestamps
    end
    add_index :images, :business_id
  end
end
