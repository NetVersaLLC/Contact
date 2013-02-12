class InsiderPage < ClientData
  attr_accessible :email, :insider_page_category_id
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true
belongs_to :insider_page_category

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      puts(mail.subject)
      STDERR.puts mail.subject
      if mail.subject =~ /Please confirm you Insider Pages account email address/i
        if mail.body.decoded =~ /(http:\/\/www.insiderpages.com\/confirm\/\S+)/i
          @link = $1
        end
      end
    end
    @link
  end

end
