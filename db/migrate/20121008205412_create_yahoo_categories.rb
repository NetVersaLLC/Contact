class CreateYahooCategories < ActiveRecord::Migration
  def change
    create_table :yahoo_categories do |t|
      t.integer :rcatid
      t.string  :catname
      t.integer :subcatid
      t.string  :subcatname
      t.boolean :subprofcontact
      t.string  :synonyms

      t.timestamps
    end
  end
end
