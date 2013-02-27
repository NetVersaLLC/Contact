@browser.goto("http://myaccount.zip.pro/find-business.php?bzName=#{data[ 'businessfixed' ]}&bzZip=#{data['zip']}&search=zip")
if @browser.text.include? "Found 0 result(s) for"

  businessFound = [:unlisted]
else

 if @browser.div( :class => "searchDisplay").span(:class => 'title', :text => /#{data['business']}/).exists?
      thelisting = @browser.div( :class => "searchDisplay").span(:class => 'title', :text => /#{data['business']}/)     
  if thelisting.parent.parent.div(:class => 'btn_wrapp').link( :class => 'claimBtn').exists?  
     businessFound = [:listed, :unclaimed]
  else
     businessFound = [:listed, :claimed]
  end             
 else
    businessFound = [:unlisted]
    
 end  
  
  
end


[true, businessFound]