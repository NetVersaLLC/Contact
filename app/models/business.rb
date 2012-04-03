class Business < ActiveRecord::Base
  attr_accessible :name, :contact, :phone,
    :alternate_phone, :fax, :address, :address2,
    :city, :state, :zip, :website, :email, :approved,
    :yelp_category_id, :mail_host, :mail_port, :mail_username,
    :mail_password
end
