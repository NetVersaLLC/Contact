CAPTURE_A_NUMBER = Transform /^\d+$/ do |number| 
  number.to_i 
end 

Given /I have (#{CAPTURE_A_NUMBER}) credits/ do |credits|
  white_label.update_attribute( :credits, credits) 
end 

And /My child has (#{CAPTURE_A_NUMBER}) credits/ do |credits| 
  white_label.children << FactoryGirl.create(:label, :credits => credits, :name => "child") 
  white_label.save 
end 

When /I add (#{CAPTURE_A_NUMBER}) credit/ do |credits|
  CreditsProcessor.new( reseller, white_label).add( {quantity: credits} ) 
end 

When /I pay with (#{CAPTURE_A_NUMBER}) credit/ do |credits|
  CreditsProcessor.new( reseller, white_label).pay( {quantity: credits} ) 
end 

When /I transfer (#{CAPTURE_A_NUMBER}) credits to a child/ do |credits|
  CreditsProcessor.new( reseller, white_label).transfer( white_label.children.first, {quantity: credits} ) 
end 

Then /I should have (#{CAPTURE_A_NUMBER}) credits/ do |credits| 
  white_label.credits.should eq(credits) 
end 

Then /My child should have (#{CAPTURE_A_NUMBER}) credits/ do |credits| 
  white_label.children.first.credits.should eq(credits) 
end 

