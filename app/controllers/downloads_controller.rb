class DownloadsController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def download
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      @download         = Download.new
      @download.user_id = current_user.id
      @download.key     = current_user.authentication_token
      @download.make_setup(@business.id)
      @download.save
      
      @business.update_column(:is_client_downloaded, true)
     
      send_file(@download.name,
                :type => "application/octet-stream",
                :disposition => "inline",
                :filename => 'setup.exe')
    end
  end

  def show 
    @business = Business.find(params[:business_id])
    download = params[:id] #will probably always be 'client' 

    respond_to do |format| 
      format.html 
      #format.exe { send_download } 
    end 

  end 
end
