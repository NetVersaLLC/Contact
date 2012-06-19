class DownloadsController < ApplicationController
  def download
    @business = Business.find(params[:business_id])
    if @business.user_id != current_user.id
      redirect_to '/'
    else
      @download         = Download.new
      @download.user_id = current_user.id
      @download.key     = current_user.authentication_token
      @download.make_setup(@business.id)
      @download.save
      send_file(@download.name,
                :type => "application/octet-stream",
                :disposition => "inline")
    end
  end
end
