class Zippro < ClientData
	attr_accessible :username, :secret1, :zippro_category_id, :zippro_category2_id 
	virtual_attr_accessor :password
belongs_to :zippro_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /Zip.pro - Account Activation/i
		if mail.body.decoded =~ /(http:\/\/myaccount.zip.pro\/verify.php\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end  

end
#14857
#10493
