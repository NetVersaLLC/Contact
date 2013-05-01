class CreateBusinessFormEdits < ActiveRecord::Migration
  def up
    create_table :business_form_edits do |t| 
      t.references :user
      t.references :business 
      t.timestamps 

      t.text :business_params
      t.string :tab 
    end 
  end

  def down
    drop_table :business_form_edits
  end
end
