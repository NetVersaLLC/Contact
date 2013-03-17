class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :status
      t.string :name
      t.integer :amount
      t.string :transaction_number
      t.integer :business_id
      t.integer :label_id
      t.integer :transaction_id
      t.string :message
      t.text :response

      t.timestamps
    end
    add_index :payments, :business_id
    add_index :payments, :label_id
    add_index :payments, :transaction_id
  end
end
