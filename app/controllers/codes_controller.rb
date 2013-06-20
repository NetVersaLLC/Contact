class CodesController < ApplicationController 

  def new 
    @code = Code.new 
    @code.business = Business.find(params[:business_id]) 
    @code.site_name = params[:site_name]
  end 

  def create 
    @code = Code.new( params[:code] ) 
    @code.business = Business.find(params[:business_id]) 
    @code.save 
    flash[:notice] = 'Code saved!' 
    redirect_to business_path(@code.business)
  end 

end 
