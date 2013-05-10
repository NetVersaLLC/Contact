class Spotbusiness < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to :spotbusiness_category

 def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Spotabusiness - Your Registration is Pending Approval/i   
        if mail.body.decoded =~ /(http:\/\/spotabusiness.com\/index.php\S+)/i
          @link = $1
        end
      end
    end
    @link
 end  
    

end
