object @business
attributes :id, :name, :contact, :phone,
    :alternate_phone, :fax, :address, :address2,
    :city, :state, :zip, :website, :email, :approved
node(:yelp_category) { |business| YelpCategory.find(business.yelp_category_id).to_list }
