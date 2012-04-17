class Business < ActiveRecord::Base
  attr_accessible :name, :contact, :phone,
    :alternate_phone, :fax, :address, :address2,
    :city, :state, :zip, :website, :email, :approved,
    :yelp_category_id, :mail_host, :mail_port, :mail_username,
    :mail_password, :first_name, :last_name, :middle_initial

  def make_contact
    [first_name, middle_initial, last_name].join(" ").gsub(/\s+/, ' ')
  end

  after_update :update_contact
  def update_contact
    if self.contact == nil
      contact = make_contact
      save
    end
  end
end
