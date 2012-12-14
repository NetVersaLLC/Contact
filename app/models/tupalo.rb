class Tupalo < ClientData
  attr_accessible :username
  virtual_attr_accessor :password


  def self.check_email(business)
    @password = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Welcome to Tupalo.com?/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
		@password = p.decoded.scan(/<b>Password:<\/b> (.*)<br\/>/)            
          end
        end
      end
    end
    STDERR.puts "Tupalo password: #{@password}"
    @password
  end


end
