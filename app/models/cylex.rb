class Cylex < ClientData  
  attr_accessible :business_id, :created_at, :email, :listing_url, :force_update, :secretsi
  virtual_attr_accessor :password
#  validates :password,
#        :presence => true
  def has_categories? 
    false
  end 

  def self.payment_methods(business)
    methods = {}
    [
      ["cash",        'ctl00$ContentPlaceHolder1$Payment$r$ctl14$cb'],
      ["checks",      'ctl00$ContentPlaceHolder1$Payment$r$ctl03$cb'],
      ["mastercard",  'ctl00$ContentPlaceHolder1$Payment$r$ctl15$cb'],
      ["visa",        'ctl00$ContentPlaceHolder1$Payment$r$ctl17$cb'],
      ["discover",    'ctl00$ContentPlaceHolder1$Payment$r$ctl05$cb'],
      ["diners",      'ctl00$ContentPlaceHolder1$Payment$r$ctl09$cb'],
      ["amex",        'ctl00$ContentPlaceHolder1$Payment$r$ctl13$cb'],
      ["paypal",      'ctl00$ContentPlaceHolder1$Payment$r$ctl16$cb']
    ].each do |row|
      methods[row[0]] = row[1]
    end
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
