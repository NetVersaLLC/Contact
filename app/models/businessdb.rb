class Businessdb < ClientData 
  attr_accessible 		:email
  virtual_attr_accessor :password
  belongs_to            :businessdb_category


 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
  	if mail.subject =~ /BusinessDB membership verify/i
  		puts(mail.subject)
  		puts(mail.body.decoded)
		if mail.body.decoded =~ /(http:\/\/www.businessdb.com\/verify\/\S+)/i
	          @link = $1
	          puts(@link)
	        end
  	end
    end
    @link
 end  


end
