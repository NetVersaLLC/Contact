class Justclicklocal < ClientData
	attr_accessible :business_id, :email, :force_update, :secrets
	virtual_attr_accessor :password
#	validates :password,
#            :presence => true

  def has_categories? 
    false
  end 

def self.coinflip
	flip = rand(100)
	if flip < (50)
		#puts("heads")
		true
	else
		#puts("tails")
		false
	end
end

def self.random_letter
	alphabet = 'A'.upto('Z').to_a
	letter = rand(26)
	if coinflip == true then
		alphabet[letter]
	else
		alphabet[letter].downcase
	end 
end

def self.make_password
	password = rand(9..14).times.collect { random_letter }.join
	return password
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
