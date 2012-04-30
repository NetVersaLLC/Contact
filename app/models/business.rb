class Business < ActiveRecord::Base
  attr_accessible :name, :contact, :phone,
    :alternate_phone, :fax, :address, :address2,
    :city, :state, :zip, :website, :email, :approved,
    :mail_host, :mail_port, :mail_username,
    :mail_password, :first_name, :last_name, :middle_name

  attr_accessible :yelp_category_id
  add_nested :yelps, :map_quests, :twitters, :facebooks

  def make_contact
    [first_name, middle_name, last_name].join(" ").gsub(/\s+/, ' ')
  end

end
