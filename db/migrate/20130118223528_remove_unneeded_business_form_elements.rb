class RemoveUnneededBusinessFormElements < ActiveRecord::Migration
  def change
    remove_column :businesses, :sic_code
    remove_column :businesses, :duns_number
    remove_column :businesses, :competitors
    remove_column :businesses, :most_like
    remove_column :businesses, :fan_page_url
    remove_column :businesses, :industry_leaders
    remove_column :businesses, :keyword1
    remove_column :businesses, :keyword2
    remove_column :businesses, :keyword3
    remove_column :businesses, :keyword4
    remove_column :businesses, :keyword5
  end
end
