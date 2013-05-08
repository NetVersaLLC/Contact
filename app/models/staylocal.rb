class Staylocal < ClientData 
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to :staylocal_category  


  def self.check_email(business)
    @password = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Account details for (.*) at Stay Local!/i
      puts(mail.body.decoded)        
			@password = mail.body.decoded.scan(/password: (.*)\s/)            
      puts(@password)
      end
    end
    STDERR.puts "Staylocal password: "+@password.to_s
    return @password[0]
  end


end
