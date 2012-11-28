class Yelp < ClientData
  attr_accessible       :email, :yelp_category_id
  virtual_attr_accessor :password
  belongs_to            :yelp_category
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true

  def self.get_signup_data(business)
    google = GoogleCategory.where(:name => business.category1).first
    if google.nil?
      throw "No Google Category Set"
    end
    cat = YelpCategory.find(google.yelp_category_id)
    data = {
      'name'          => "#{business.contact_first_name} #{business.contact_last_name}",
      'city'          => business.city,
      'address'       => business.address,
      'address2'      => business.address2,
      'state'         => business.state,
      'zip'           => business.zip,
      'phone'         => business.local_phone,
      'website'       => business.company_website,
      'yelp_category' => cat.to_list,
      'email'         => business.accounts.first.email
    }
  end

  def self.my_mail(mail)
    if mail.subject =~ /Verify Your Email Address/
      true
    else
      false
    end
  end

  def self.get_link(mail)
    if mail.body =~ /(https:\/\/biz.yelp.com\/signup\/confirm\/\S+)/
      $1
    else
      nil
    end
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Verify Your Email Address/
        if mail.body =~ /(https:\/\/biz.yelp.com\/signup\/confirm\/\S+)/
          @link = $1
        end
      end
    end
    @link
  end

end
