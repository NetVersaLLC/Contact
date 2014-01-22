class Facebook < ClientData
  attr_accessible :email, :cookies, :status
  virtual_attr_accessor :password
  belongs_to :facebook_category
  belongs_to :facebook_profile_category


  def Facebook.data
    hash = Business.find_by_user_id(self.user_id).to_hash
    hash[:email]    = self.email
    hash[:password] = self.password
  end

 def self.check_email(business)
    @link = nil
      CheckMail.get_link(business) do |mail|
        if mail.subject =~ /Action Required: Confirm Your Facebook Account/i
          if mail.body.decoded =~ /(http:\/\/www.facebook.com\/c.php?\S+)/i
            @link = $1
          end
        end
        if mail.subject =~ /Just one more step to get started on Facebook/i
          mail.parts.map do |p|
            if p.content_type =~ /text\/html/
              nok = Nokogiri::HTML(p.decoded) 
              @link = nok.xpath("//a")[0].attr('href')               
            end
          end
        end
        
      end
      return @link
 end  
#http://www.facebook.com/confirmemail.php?e=boehmglover1302%40outlook.com&c=181089



#Action Required: Confirm Your Facebook Account‏
#http://www.facebook.com/c.php?code=704203098&email=runtetreutelandsatterfield3996%40outlook.com&sig=AeaG-zqjHQU9sBPU
#You may be asked to enter this confirmation code: 704203098


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



end
