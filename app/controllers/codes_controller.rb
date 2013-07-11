class CodesController < ApplicationController 
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def new 
    Code.delete_all(:business_id => params[:business_id], :site_name => params[:site_name]  ) 

    @code = Code.new 
    @code.business = Business.find(params[:business_id]) 
    @code.site_name = params[:site_name]
    @code.next_job = params[:next_job]
    
    if params[:screen_to_phone] 
      render 'new_screen_to_phone' 
    else 
      render 
    end 
  end 

  def create 
    if params[:code] # from the form 
      @code = Code.new( params[:code] ) 
    else 
      @code = Code.new( site_name: params[:site_name], code: params[:code]) 
    end 
   
    @code.business = Business.find(params[:business_id]) 
     if params[:next_job]
      @code.next_job = params[:next_job]
    end
    @code.save 

    respond_to do |format| 
      format.html do
          flash[:notice] = 'Code saved!'
          redirect_to business_path(@code.business)
      end
      format.json { render :nothing => true, :status => :created } 
    end 
  end 

  def destroy
    @code = Code.where( :business_id => params[:business_id], :site_name => params[:site_name] ).first
    if @code.nil? 
      render :nothing => true, :status => :not_found
    else 
      @code.delete
      render :json => @code
    end 
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
