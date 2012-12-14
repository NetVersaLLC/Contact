class AddCaptchaSolvesToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :captcha_solves, :integer, :default => 200
  end
end
