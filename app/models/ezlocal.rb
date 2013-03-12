class Ezlocal < ClientData
  attr_accessible :email, :ezlocal_category_id
  virtual_attr_accessor :password
  belongs_to :ezlocal_category



 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /EZlocal: Please Confirm Account/i
		if mail.body.decoded =~ /(http:\/\/ezlocal.us1.list-manage.com\/subscribe\/\S+)/i
	          @link = $1
	          @link = @link.gsub(")","")
	        end
  	end
    end
    @link
 end  



  def self.get_temp_password(business)
    @password = nil
    CheckMail.get_link(business) do |mail|
      	if mail.subject =~ /EZlocal: Subscription Confirmed/i                  
      		puts(mail.body.decoded)
				 if mail.body.decoded =~ /(Your temporary password is: )(.*?)(=0A)/i
				 	@password = $2
				 end
          end        
      
      #/<strong> Member ID:<\/strong> (.*?)<\/li>/i
    end
    STDERR.puts "Ezlocal password: #{@password}"
    @password
  end

  def self.payment_methods(business)
    methods = {}
    [      
      ["checks",    'Personal Checks'],
      ["visa",      'chkVisa'],
      ["mastercard",'chkMasterCard'],
      ["amex",      'chkAmex'],
      ["discover",  'chkDiscover'],
      ["diners",    'chkDinersClub'],
      ["paypal",	'chkPaypal']
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
						business.send("#{day}_open".to_sym).downcase.gsub("am"," a.m.").gsub("pm"," p.m."),
						business.send("#{day}_close".to_sym).downcase.gsub("am"," a.m.").gsub("pm"," p.m.")
					]				
		else
			hours[ "#{day}" ] = ["Closed"]

		end
	end

	return hours
end



end
