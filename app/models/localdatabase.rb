class Localdatabase < ClientData
  attr_accessible :username
  virtual_attr_accessor :password

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      puts(mail.subject)
      STDERR.puts mail.subject
      if mail.subject =~ /Action Required to Activate Membership for Local Database/i
        if mail.body.decoded =~ /(http:\/\/www.localdatabase.com\/forum\/register.php\?a=act\S+)/i
          @link = $1
        end
      end
    end
    STDERR.puts "Localdatabase link: #{@link}"
    @link
  end

end
