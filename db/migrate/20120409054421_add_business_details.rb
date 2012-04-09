class AddBusinessDetails < ActiveRecord::Migration
  def change
    add_column :businesses, :short_description, :text
    add_column :businesses, :long_description, :text
    add_column :businesses, :hours, :string
    add_column :businesses, :payment_methods, :string
    add_column :businesses, :descriptive_keyword, :string
    add_column :businesses, :keywords, :string
  end
end
