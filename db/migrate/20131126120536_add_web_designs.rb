class AddWebDesigns < ActiveRecord::Migration
  def up
    create_table :web_designs do |t| 
      t.string :page_name, null: false
      t.text :body, null: false
      t.text :special_instructions #, default: ''

      t.timestamps 
      t.references :business
    end 
  end

  def down
    drop_table :web_designs
  end
end
