class NotificationsController < InheritedResources::Base
  #before_filter :authenticate_user!
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

#  def index
#    @notifications = Notification.where(:business_id => params[:business_id])
#    respond_to do |format|
#      format.html { render 'index', layout: false }
#      format.json do
#        html = render_to_string 'list', layout: false, formats: [:html]
#        data = {
#          :html => html,
#          :notifications => @notifications
#        }
#        render json: data
#      end
#    end
#  end

#  def edit
#    @notification = Notification.find(params[:id])
#    respond_to do |format|
#      format.html { render 'edit', layout: false }
#    end
#  end
#
#  def update
#    @notification = Notification.find(params[:id])
#    @notification.update_attributes(params[:notification])
#    render :json => @notification
#  end
#
#  def new
#    @notification = Notification.new
#    respond_to do |format|
#      format.html { render 'edit', layout: false }
#    end
#  end
#
#  def show
#    @notification = Notification.find(params[:id])
#  end
#
#  def create
#    @notification = Notification.create(params[:notification])
#    render json: @notification
#  end
#
#  def destroy
#    Notification.find(params[:id]).delete
#    render json: true
#  end

end
