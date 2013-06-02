class AddTwitterPageToTwitter < ActiveRecord::Migration
  def change
    add_column :twitters, :twitter_page, :string
  end
end
