class CodesController < ApplicationController 

  def new 
    Code.delete_all(:business_id => params[:business_id], :site_name => params[:site_name]  ) 

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

  def site_code
    @code = Code.where( :business_id => params[:business_id], :site_name => params[:site_name] ).first
    if @code.nil? 
      render :nothing => true, :status => :not_found
    else 
      render :json => @code
    end 
  end 

end 
