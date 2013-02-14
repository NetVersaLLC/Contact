class CreateExpressupdateusas < ActiveRecord::Migration
  def change
       create_table :expressupdateusas do |t|
         t.integer  :business_id
         t.datetime :force_update
         t.text     :secrets
         t.string   :email
         t.timestamps
       end
  end
end
