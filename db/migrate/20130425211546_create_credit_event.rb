class CreateCreditEvent < ActiveRecord::Migration
  def up
    create_table :credit_events do |t|  
      t.integer  :quantity, :default => 0
      t.string   :action, :null => false 
      t.string   :note 
      t.integer  :other_id 
      
      t.references :label, :null => false 
      t.references :user 
      t.timestamps 
    end 

  end

  def down
    drop_table :credit_events 
  end
end
