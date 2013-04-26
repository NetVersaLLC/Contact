class Localdatabase < ClientData
attr_accessible :username
virtual_attr_accessor :password
belongs_to :localdatabase_category

  def self.check_email(business)
    link = nil
    CheckMail.get_link(business) do |mail|            
      if mail.subject =~ /Action Required to Activate Membership for Local Database/i
        if mail.body.decoded =~ /(http:\/\/www.localdatabase.com\/forum\/register.php\?a=act\S+)/i
          link = $1
          puts(link)
          break
        end
      end
    end    
    puts(link)
    return link
    puts "After return which shouldn't happen"
  end

end
