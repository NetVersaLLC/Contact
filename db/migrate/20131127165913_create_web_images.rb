class CreateWebImages < ActiveRecord::Migration
  def up
    create_table :web_images do |t| 
      t.timestamps
      t.references :web_design
    end 
  end

  def down
    drop_table :web_images
  end
end
