class AddBusinessModelDefaults < ActiveRecord::Migration
  def up
      change_column_default( :businesses,   :monday_enabled,  true)
      change_column_default( :businesses,   :tuesday_enabled,  true)
      change_column_default( :businesses,   :wednesday_enabled,  true)
      change_column_default( :businesses,   :thursday_enabled,  true)
      change_column_default( :businesses,   :friday_enabled,  true)
      change_column_default( :businesses,    :monday_open,  '8:30AM')
      change_column_default( :businesses,    :monday_close,  '5:30PM')
      change_column_default( :businesses,    :tuesday_open,  '8:30AM')
      change_column_default( :businesses,    :tuesday_close,  '5:30PM')
      change_column_default( :businesses,    :wednesday_open,  '8:30AM')
      change_column_default( :businesses,    :wednesday_close,  '5:30PM')
      change_column_default( :businesses,    :thursday_open,  '8:30AM')
      change_column_default( :businesses,    :thursday_close,  '5:30PM')
      change_column_default( :businesses,    :friday_open,  '8:30AM')
      change_column_default( :businesses,    :friday_close,  '5:30PM')
      change_column_default( :businesses,   :accepts_cash,  true)
      change_column_default( :businesses,   :accepts_checks,  true)
      change_column_default( :businesses,   :accepts_mastercard,  true)
      change_column_default( :businesses,   :accepts_visa,  true)
      change_column_default( :businesses,   :accepts_discover,  true)
      change_column_default( :businesses,   :accepts_diners,  false)
      change_column_default( :businesses,   :accepts_amex,  true)
      change_column_default( :businesses,   :accepts_paypal,  false)
      change_column_default( :businesses,   :accepts_bitcoin,  false )
  end

  def down
  end
end
