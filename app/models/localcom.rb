class Localcom < ClientData
  attr_accessible :username, :status
  virtual_attr_accessor :password
  
  def has_categories? 
    false
  end 

   def self.payment_methods(business)
    methods = {}
    [
      ["cash",      '2'],
      ["checks",    '10'],
      ["visa",      '12'],
      ["mastercard",'7'],
      ["amex",      '1'],
      ["discover",  '5'],
      ["diners",    '4']
    ].each do |row|
      methods[row[0]] = row[1]
    end
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    accepted
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

		end
	end

	return hours
end  
  
end
