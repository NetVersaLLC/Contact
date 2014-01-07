class CodesController < ApplicationController 
  prepend_before_filter :authenticate_user_from_token!
  skip_before_filter :verify_authenticity_token


  def new 
    Code.delete_all(:business_id => params[:business_id], :site_name => params[:site_name]  ) 

    @code = Code.new 
    @code.business = Business.find(params[:business_id]) 
    @code.site_name = params[:site_name]
    @code.next_job = params[:next_job]
    
    if params[:screen_to_phone] 
      render 'new_screen_to_phone' 
    elsif params[:mail] 
      render 'new_mail_verify'
    elsif params[:site_name] == 'yahoo' 
      render 'new_yahoo'
    elsif params[:site_name] == 'google' && params[:next_job] == 'notify' 
      render 'new_google_notify'
    else
      render 
    end 
  end 

  def account

    google = Google.find_by_business_id( params[:business_id]) || Google.new
    google.business_id = params[:business_id] # in case it's new
    google.password = params[:password]
    google.email = params[:email] 
    google.save

    payload = Payload.start("Google/CreateListing")

    job = Job.new
    job = Job.inject(params[:business_id], payload.client_script, payload.data_generator, payload.ready, Time.now - 5.hours)
    job.name = "Google/CreateListing" 
    job.payload_id = payload.id
    job.save

    Notification.where("url like '%google%' and business_id = ?", params[:business_id]).first.delete
    respond_to do |format| 
      format.html do
        flash[:notice] = 'Credentials saved!'
        redirect_to dashboard_index_url
      end
      format.json { render :nothing => true, :status => :created } 
    end 
  end 


  def create
    if params[:code] and not params[:site_name] # from the form 
      @code = Code.new( :code => params[:code][:code], site_name: params[:code][:site_name]) 
    else
      @code = Code.new( site_name: params[:site_name], code: params[:code]) 
    end
    @code.business = Business.find(params[:business_id]) 
     if params[:next_job]
      @code.next_job = params[:next_job]
    end
    @code.save

    #remove the notification/pending action
    Notification.where("url like ? and business_id = ?","%#{params[:code][:site_name]}%", params[:business_id]).first.delete
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
