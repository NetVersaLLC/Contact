class Nsphere  < ClientData 
  attr_accessible         :username, :email
  virtual_attr_accessor   :password
  belongs_to              :nsphere_category

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /nSphere Registration Confirmation/i
        if mail.body.decoded =~ /(http:\/\/vendor.nsphere.net\/link\.aspx.+)/i
          @link = $1
        end
      end
      @link
    end
  end

end
