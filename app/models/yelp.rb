class Yelp < ClientData
  attr_accessible :email, :yelp_category_id
  virtual_attr_accessor :password
  belongs_to :yelp_category
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true

  def data(business)
    cat = YelpCategory.find(GoogleCategory.where(:name, business.category1).first.yelp_category_id)
    data = {
      'name'          => "#{business.first_name} #{business.last_name}",
      'city'          => business.city,
      'address'       => business.address,
      'address2'      => business.address2,
      'state'         => business.state,
      'zip'           => business.zip,
      'phone'         => business.local_phone,
      'website'       => business.website,
      'yelp_category' => cat.to_list,
      'email'         => business.email
    }
  end
end
