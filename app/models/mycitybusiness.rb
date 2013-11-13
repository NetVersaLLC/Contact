class Mycitybusiness < ClientData
	virtual_attr_accessor :password


  def has_categories? 
    false
  end 



 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /myCity Business Activation Link/i
		if mail.body.decoded =~ /(http:\/\/www.mycitybusiness.net\/activate.php\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  



end
