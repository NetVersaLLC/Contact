class CreateCodes < ActiveRecord::Migration
  def up
    create_table :codes do |t| 
      t.string :code 
      t.string :site_name 

      t.references :business
      t.timestamps 
    end
  end

  def down
    drop_table :codes
  end
end
