class AddMissingBusinessColumns < ActiveRecord::Migration
  def change
    add_column :businesses, :keywords, :string
    add_column :businesses, :status_message, :string
    add_column :businesses, :services_offered, :string
    add_column :businesses, :trade_license, :boolean
    add_column :businesses, :trade_license_number, :string
    add_column :businesses, :trade_license_locale, :string
    add_column :businesses, :trade_license_authority, :string
    add_column :businesses, :trade_license_expiration, :string
    add_column :businesses, :trade_license_description, :string
    add_column :businesses, :brands, :string
    add_column :businesses, :tag_line, :string
    add_column :businesses, :job_titles, :text
  end
end
