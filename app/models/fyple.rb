class Fyple < ClientData
  belongs_to :fyple_category
  attr_accessible :email, :status
  virtual_attr_accessor :password
  validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.payments(business) 
    #data['payments'] = ['American Express','Cash','Cheque', "Diner's club", 'Discover','Mastercard','Visa']

    p = []
    p << "American Express" if business.accepts_amex
    p << "Cash"             if business.accepts_cash
    p << "Cheque"           if business.accepts_checks
    p << "Diner's club"     if business.accepts_diners
    p << "Discover"         if business.accepts_discover 
    p << "Mastercard"       if business.accepts_mastercard 
    p << "Visa"             if business.accepts_visa
    p
  end 
end 
