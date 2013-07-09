class Justclicklocal < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
#	validates :password,
#            :presence => true


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
