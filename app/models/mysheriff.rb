class Mysheriff < ClientData  
  attr_accessible :business_id, :created_at, :email, :listing_url, :force_update, :secretsi, :status
  virtual_attr_accessor :password
#  validates :password,
#        :presence => true
  def has_categories? 
    true
  end 
  def self.make_password 
    (SecureRandom.random_number * 10000000000000).to_i.to_s(36) 
  end

  def self.payment_methods(business)
    methods = {
      cash:       "cash",
      checks:     "cheque",
      mastercard: "mastercard",
      visa:       "visa",
      #discover:   "discover",
      diners:     "diners_club",
      amex:       "american_express",
      paypal:     "paypal"
    }
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    return accepted
  end

  def self.get_hours(business)
    hours = {}
    days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday']
    days.each do |day|
      day_nnn = day[0..2]
      day_nnn = 'thur' if day == 'thursday' 

      if business.send("#{day}_enabled".to_sym) == true
          hours[ "#{day_nnn}_open" ] = business.send("#{day}_open".to_sym).downcase.gsub(/\A0/,"")
          hours[ "#{day_nnn}_close" ] = business.send("#{day}_close".to_sym).downcase.gsub(/\A0/,"")
      else
        hours[ "#{day_nnn}_open" ] = "Closed"
        hours[ "#{day_nnn}_close" ] = "Closed"
      end
    end
    return hours
  end  

end
