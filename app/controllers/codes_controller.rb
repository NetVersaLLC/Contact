class CodesController < ApplicationController 

  def new 
    @code = Code.new 
    @code.business = Business.find(params[:business_id]) 
  end 

  def create 
    @code = Code.new 
    @code.business = Business.find(params[:business_id]) 
    @code.attributes( params[:code] ) 
    @code.save 



  end 

end 
