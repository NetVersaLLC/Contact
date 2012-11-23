class Superpage < ClientData
  attr_accessible :email
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }


  def self.check_email(business)
    @link = {}
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Action Required: Confirm Your SuperMedia Account/
      	if mail.body =~ /(Temporary Password: \S+)/
          @link[ 'temp_pass' ] = $1
        end
        if mail.body =~ /(http:\/\/cl.exct.net\/?qs=\S+)/
          @link[ 'link' ] = $1
        end
      end
    end
    @link
  end

def self.make_payments(business)
    methods = {
      'cash'       => 'Cash',
      'checks'     => 'Checks',
      'mastercard' => 'Mastercard',
      'visa'       => 'Visa',
      'discover'   => 'Discover',
      'diners'     => "Diner's Club",
      'amex'       => 'American Express',
      'paypal'     => 'Paypal online'
    }

end




end
