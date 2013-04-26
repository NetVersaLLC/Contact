class Showmelocal < ClientData
	attr_accessible :username, :showmelocal_category_id
	virtual_attr_accessor :password
belongs_to :showmelocal_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Welcome to the ShowMeLocal\.com/i
	          @link = mail.body.decoded.match(/(http:\/\/www.showmelocal.com\S+)/i)[1]
  	end
    end
    @link
 end  

	
def self.get_hours(business)
hours = {}
days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday']
  days.each do |day|
    if business.send("#{day}_enabled".to_sym) == true
      hours[ "#{day}" ] =
          {
            "open" => business.send("#{day}_open".to_sym).downcase.gsub("am"," am").gsub("pm"," pm"),
            "close" => business.send("#{day}_close".to_sym).downcase.gsub("am"," am").gsub("pm"," pm")
          }
        
    else
      hours[ "#{day}" ] = "closed"
    end
  end

  return hours
end 


  def self.payment_methods(business)
    methods = {}
    [
      ["cash",      '_ctl0_chkCash'],
      ["checks",    '_ctl0_chkPersonalChecks'],
      ["visa",      '_ctl0_chkVisa'],
      ["mastercard",'_ctl0_chkMasterCard'],
      ["amex",      '_ctl0_chkAmex'],
      ["discover",  '_ctl0_chkDiscover']
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
