class Localndex < ClientData
	attr_accessible :username, :email
	virtual_attr_accessor :password
	#validates :password,
  #          :presence => true


  def has_categories? 
    false
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
  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Localndex - Activation/i
        mail.parts.map do |p|
			if p.content_type =~ /text\/html/
				nok = Nokogiri::HTML(p.decoded)
				nok.xpath("//a").each do |link|
					if link.attr('href') =~ /http:\/\/www.localndex.com\/register.aspx\?*/
						@link = link.attr('href')
					end
				end
			end
        end
      end
    end
    STDERR.puts "Localndex mail actication link: #{@link}"
    @link
  end
end
