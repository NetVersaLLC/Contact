class Mysheriff < ClientData  
  attr_accessible :business_id, :created_at, :email, :listing_url, :force_update, :secretsi, :status
  virtual_attr_accessor :password
#  validates :password,
#        :presence => true
  def has_categories? 
    true
  end 

  def self.payment_methods(business)
    prefix = 'ctl00$ContentPlaceHolder1$Payment$r$ctl__ID__$cb'
    methods = {
      cash:       "14",
      checks:     "03",
      mastercard: "15",
      visa:       "17",
      discover:   "05",
      diners:     "09",
      amex:       "13",
      paypal:     "16"
    }
    methods = methods.merge(methods){|method,id|prefix.gsub("__ID__",id.to_s)}
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
        if business.send("#{day}_enabled".to_sym) == true
            hours[ "#{day}" ] =
                [
                    business.send("#{day}_open".to_sym).downcase.gsub("am"," am").gsub("pm"," pm"),
                    business.send("#{day}_close".to_sym).downcase.gsub("am"," am").gsub("pm"," pm")
                ]

        else
          hours[ "#{day}" ] = nil
        end
    end
        return hours
  end  

end
