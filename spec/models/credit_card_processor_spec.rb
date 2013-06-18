require 'spec_helper'

describe CreditCardProcessor do 

  it 'validates credit cards' do 
    cc = { 
      :first_name => 'first', 
      :last_name => 'last', 
      :brand => 'visa', 
      :number => '4242424242424242', 
      :verification_value => '123', 
      :month => '12', 
      :year => '2016' } 

    ccp = CreditCardProcessor.new(nil, cc ) 
    ccp.is_credit_card_valid?.should eq(true)
   
    cc[:number] = '1234123412341234'  
    ccp = CreditCardProcessor.new(nil, cc ) 
    ccp.is_credit_card_valid?.should eq(false)
    ccp.credit_card_errors.blank?.should eq(false)
  end 

  it 'doesnt hit the gateway for zero dollar charge' do 
    cc = { 
      :first_name => 'first', 
      :last_name => 'last', 
      :brand => 'visa', 
      :number => '4242424242424242', 
      :verification_value => '123', 
      :month => '12', 
      :year => '2016' } 
    ccp = CreditCardProcessor.new(nil, cc ) 
    ccp.charge(0).message.should eq('Free checkout') 
  end 

end 
