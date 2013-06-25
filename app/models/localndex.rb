class Localndex < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	#validates :password,
  #          :presence => true



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
			hours[ "#{day}" ] = [ "closed" ]
		end
	end

	return hours
end	


  def self.payment_methods(business)
    methods = {}
    [
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'AmEx'],
      ["discover",  'Discover'],
      ["diners",    'Diners']
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



end
